import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:frond_end_rental/constant/colors.dart';
import 'package:frond_end_rental/constant/conection.dart';
import 'package:frond_end_rental/provider/transaction_provider.dart';
import 'package:frond_end_rental/utils/auth_uril.dart';
import 'package:frond_end_rental/utils/security.dart';
import 'package:frond_end_rental/widget/route_bottom_sheet.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ionicons/ionicons.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<LatLng> routePoints = [];
  List<LatLng> startEnds = [];
  bool preLoad = true;
  Map<String, dynamic> data = {};
  LatLng? currentLoc;
  Timer? _timer;
  double? distance;

  @override
  void initState() {
    super.initState();
    fetchMapData();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  void fetchMapData() async {
    final value = await getToken();
    if (value == null) {
      showUnAuthorizedError(context);
      Navigator.of(context).pushReplacementNamed('/');
    } else {
      final packageData = await getCurrentNavigation();
      if (packageData == null) {
        Navigator.of(context).pushNamed('/history');
      } else {
        await initializeMapData(packageData);
      }
    }
  }

  Future<void> initializeMapData(packageData) async {
    try {
      final response = await getDataPackage(packageData);
      final startL = LatLng(
        double.parse(response['package']['lat_start']),
        double.parse(response['package']['lngt_start']),
      );
      final endL = LatLng(
        double.parse(response['package']['lat_destination']),
        double.parse(response['package']['lngt_destination']),
      );

      setState(() {
        data = response;
        startEnds = [startL, endL];
        preLoad = false;
      });

      await getRoute(startL, endL);

      await Geolocator.requestPermission();

      _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation,
        );
        final newLoc = LatLng(position.latitude, position.longitude);

        final putDistance = Geolocator.distanceBetween(
          newLoc.latitude,
          newLoc.longitude,
          startEnds[1].latitude,
          startEnds[1].longitude,
        );

        setState(() {
          distance = putDistance;
          currentLoc = newLoc;
        });
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          backgroundColor: const Color.fromARGB(255, 211, 65, 54),
        ),
      );
      Navigator.of(context).pop();
    }
  }

  Future<void> getRoute(LatLng start, LatLng end) async {
    var url =
        'https://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?steps=true&annotations=true&geometries=geojson&overview=full';
    var response = await client.get<Map<String, dynamic>>(url);

    setState(() {
      final ruter =
          response.data?['routes'][0]['geometry']['coordinates'] ?? [];
      for (int i = 0; i < ruter.length; i++) {
        var reep = ruter[i].toString();
        reep = reep.replaceAll("[", "");
        reep = reep.replaceAll("]", "");
        final loc = reep.split(',');

        routePoints.add(LatLng(double.parse(loc[1]), double.parse(loc[0])));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rute"),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/history');
          },
          child: const Icon(
            Ionicons.chevron_back_outline,
            color: blackColor,
          ),
        ),
      ),
      body: preLoad
          ? const Center(
              child: CircularProgressIndicator(color: primaryColor),
            )
          : buildMapWithMarkers(),
    );
  }

  Widget buildMapWithMarkers() {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            center: startEnds[0],
            zoom: 15.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: 30.0,
                  height: 30.0,
                  point: startEnds[0],
                  builder: (ctx) => IconButton(
                    icon: const Icon(Icons.location_on),
                    color: Colors.red,
                    iconSize: 30.0,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: 30.0,
                  height: 30.0,
                  point: startEnds[1],
                  builder: (ctx) => IconButton(
                    icon: const Icon(Icons.location_on),
                    color: Colors.red,
                    iconSize: 30.0,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: 30.0,
                  height: 30.0,
                  point: currentLoc ?? startEnds[0],
                  builder: (ctx) => IconButton(
                    icon: const Icon(Ionicons.bicycle),
                    color: Colors.red,
                    iconSize: 30.0,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            PolylineLayer(
              polylines: [
                Polyline(
                  points: routePoints,
                  color: Colors.red,
                  strokeWidth: 3.0,
                ),
              ],
            ),
          ],
        ),
        (distance != null && distance! >= 40)
            ? Positioned(
                bottom: 16.0,
                left: 16.0,
                right: 16.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.09),
                        offset: Offset(0, 1),
                        blurRadius: 1,
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return const PakcageBottomSheet();
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 92, 92, 92),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          "Extend Paket",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<TransactionProvider>()
                              .setBike(data['bike']['id']);

                          markAsDone(encryptId(data['id'])).then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Sukses'),
                                backgroundColor: greenPrimary,
                              ),
                            );
                            Navigator.of(context)
                                .pushReplacementNamed('/history');
                          }).catchError((err) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor:
                                    const Color.fromARGB(255, 211, 65, 54),
                                content: Text(
                                  err.toString(),
                                ),
                              ),
                            );
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: greenPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          "Mark Selesai",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
