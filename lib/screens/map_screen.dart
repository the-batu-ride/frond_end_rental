import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:frond_end_rental/constant/colors.dart';
import 'package:frond_end_rental/constant/conection.dart';
import 'package:frond_end_rental/utils/auth_uril.dart';
import 'package:frond_end_rental/utils/security.dart';
import 'package:frond_end_rental/widget/route_bottom_sheet.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ionicons/ionicons.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

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

  Future<dynamic> getRoute(LatLng start, LatLng end) async {
    var v1 = start.latitude;
    var v2 = start.longitude;
    var v3 = end.latitude;
    var v4 = end.longitude;
    var url =
        'http://router.project-osrm.org/route/v1/driving/$v2,$v1;$v4,$v3?steps=true&annotations=true&geometries=geojson&overview=full';
    var response = await client.get<Map<String, dynamic>>(url);

    setState(() {
      var ruter = response.data?['routes'][0]['geometry']['coordinates'] ?? [];
      for (int i = 0; i < ruter.length; i++) {
        var reep = ruter[i].toString();
        reep = reep.replaceAll("[", "");
        reep = reep.replaceAll("]", "");
        var lat1 = reep.split(',');
        var long1 = reep.split(",");
        routePoints.add(LatLng(double.parse(lat1[1]), double.parse(long1[0])));
      }
    });
  }

  @override
  void initState() {
    getToken().then((value) {
      if (value == null) {
        showUnAuthorizedError(context);
        Navigator.of(context).pushReplacementNamed('/');
        return;
      }

      getCurrentNavigation().then((value) {
        if (value == null) {
          Navigator.of(context).pop();
        } else {
          getDataPackage(value).then((response) {
            var startL = LatLng(
              double.parse(response['package']['lat_start']),
              double.parse(response['package']['lngt_start']),
            );
            var endL = LatLng(
              double.parse(response['package']['lat_destination']),
              double.parse(response['package']['lngt_destination']),
            );

            setState(() {
              data = response;
              startEnds = [startL, endL];
              preLoad = false;
            });

            getRoute(startL, endL).then((_) async {
              await Geolocator.requestPermission();

              _timer =
                  Timer.periodic(const Duration(seconds: 5), (timer) async {
                final position = await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.bestForNavigation,
                );

                setState(() {
                  currentLoc = LatLng(position.latitude, position.longitude);
                });
              });
            });
          }).catchError((err) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(err.toString()),
                backgroundColor: const Color.fromARGB(255, 211, 65, 54),
              ),
            );
            Navigator.of(context).pop();
          });
        }
      }).catchError((err) {});
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rute "),
      ),
      body: preLoad
          ? const Center(
              child: CircularProgressIndicator(color: primaryColor),
            )
          : Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    center: startEnds[0],
                    zoom: 15.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
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
                Positioned(
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
                ),
              ],
            ),
    );
  }
}
