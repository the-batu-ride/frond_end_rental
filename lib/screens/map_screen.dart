import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:frond_end_rental/constant/conection.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ionicons/ionicons.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  final Map<String, dynamic>? package;

  const MapScreen({super.key, this.package});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<LatLng> routePoints = [];
  List<LatLng> startEnds = [];
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
    if (widget.package == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });
      return;
    } else {
      var startL = LatLng(
        double.parse(widget.package!['lat_start']),
        double.parse(widget.package!['lngt_start']),
      );
      var endL = LatLng(
        double.parse(widget.package!['lat_destination']),
        double.parse(widget.package!['lngt_destination']),
      );

      setState(() {
        startEnds = [startL, endL];
      });

      getRoute(startL, endL).then((_) async {
        await Geolocator.requestPermission();

        _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
          final position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.bestForNavigation,
          );

          setState(() {
            currentLoc = LatLng(position.latitude, position.longitude);
          });
        });
      });

      super.initState();
    }
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
        title: Text("Rute "),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: widget.package == null ? null : startEnds[0],
          zoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          widget.package != null
              ? MarkerLayer(
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
                )
              : SizedBox(),
          widget.package != null
              ? MarkerLayer(
                  markers: [
                    Marker(
                      width: 30.0,
                      height: 30.0,
                      point: startEnds[
                          1], // Koordinat untuk penanda (Jakarta, Indonesia)
                      builder: (ctx) => IconButton(
                        icon: const Icon(Icons.location_on),
                        color: Colors.red,
                        iconSize: 30.0,
                        onPressed: () {},
                      ),
                    ),
                  ],
                )
              : SizedBox(),
          widget.package != null
              ? MarkerLayer(
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
                )
              : SizedBox(),
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
    );
  }
}
