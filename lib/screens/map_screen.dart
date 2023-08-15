import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:frond_end_rental/bloc/auth/auth_bloc.dart';
import 'package:frond_end_rental/bloc/map/map_bloc.dart';
import 'package:frond_end_rental/constant/colors.dart';
import 'package:frond_end_rental/models/package.dart';
import 'package:frond_end_rental/utils/security.dart';
import 'package:frond_end_rental/widget/loader.dart' show CenterLoader;
import 'package:geolocator/geolocator.dart' show LocationAccuracy, Geolocator;
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart' show Ionicons;
import 'package:latlong2/latlong.dart' show LatLng;

class MapScreen extends StatefulWidget {
  final String code;
  const MapScreen({Key? key, required this.code}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchMapData(context);
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  void fetchMapData(BuildContext context) {
    context.read<MapBloc>().add(LoadMap(decryptId(widget.code)));
    initializeMapData(context);
  }

  Future<void> initializeMapData(BuildContext context) async {
    await Geolocator.requestPermission();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      ).then((value) {
        final location = LatLng(value.latitude, value.longitude);

        context.read<MapBloc>().add(UpdateLocation(location));
      }).catchError((_) {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rute'),
        leading: GestureDetector(
          onTap: () => context.goNamed('history'),
          child: const Icon(
            Ionicons.chevron_back_outline,
            color: blackColor,
          ),
        ),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (_, state) {
          if (state is SignedIn) {
            return BlocSelector<MapBloc, MapState, MapStatus>(
              selector: (state) => state.status,
              builder: (_, status) {
                if (status == MapStatus.initial) {
                  return const CenterLoader();
                }

                return buildMapWithMarkers();
              },
            );
          }

          return const CenterLoader();
        },
      ),
    );
  }

  Widget buildMapWithMarkers() {
    return BlocSelector<MapBloc, MapState, List<LatLng>?>(
      selector: (state) => state.points,
      builder: (_, points) {
        return Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                center: points?.first,
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
                      point: points!.first,
                      builder: (_) => IconButton(
                        icon: const Icon(Icons.location_on),
                        color: Colors.red,
                        iconSize: 30.0,
                        onPressed: () {},
                      ),
                    ),
                    Marker(
                      width: 30.0,
                      height: 30.0,
                      point: points.last,
                      builder: (_) => IconButton(
                        icon: const Icon(Icons.location_on),
                        color: Colors.red,
                        iconSize: 30.0,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                BlocSelector<MapBloc, MapState, List<Point>>(
                  selector: (selecBoots) => selecBoots.boots,
                  builder: (_, boots) {
                    return MarkerLayer(
                      markers: boots
                          .map(
                            (e) => Marker(
                              width: 30,
                              height: 30,
                              point: LatLng(e.lat, e.lng),
                              builder: (context) => IconButton(
                                iconSize: 20,
                                color: const Color.fromARGB(255, 1, 10, 80),
                                onPressed: () {},
                                icon: const Icon(Ionicons.ellipse_outline),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
                BlocSelector<MapBloc, MapState, LatLng?>(
                  selector: (state) => state.currentLoc,
                  builder: (_, currentLoc) {
                    return MarkerLayer(
                      markers: [
                        Marker(
                          width: 30.0,
                          height: 30.0,
                          point: currentLoc!,
                          builder: (_) => IconButton(
                            icon: const Icon(Ionicons.bicycle),
                            color: Colors.red,
                            iconSize: 30.0,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    );
                  },
                ),
                BlocSelector<MapBloc, MapState, List<LatLng>>(
                  selector: (state) => state.routePoints,
                  builder: (_, routePoints) {
                    return PolylineLayer(
                      polylines: [
                        Polyline(
                          points: routePoints,
                          color: Colors.red,
                          strokeWidth: 3.0,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            BlocSelector<MapBloc, MapState, double?>(
              selector: (state) => state.disntance,
              builder: (_, distance) {
                print(distance);
                if (distance != null && distance <= 320) {
                  return Positioned(
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
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 92, 92, 92),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text(
                              'Extend Paket',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: greenPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text(
                              'Mark Selesai',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          ],
        );
      },
    );
  }
}
