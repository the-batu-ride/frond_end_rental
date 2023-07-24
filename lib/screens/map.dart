import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Maps with Leaflet'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(-6.1754,
              106.8272), // Koordinat untuk pusat peta (Jakarta, Indonesia)
          zoom: 13.0, // Tingkat zoom awal
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          // Tambahkan marker (penanda) pada peta
          MarkerLayer(
            markers: [
              Marker(
                width: 45.0,
                height: 45.0,
                point: LatLng(-6.1754,
                    106.8272), // Koordinat untuk penanda (Jakarta, Indonesia)
                builder: (ctx) => Container(
                  child: IconButton(
                    icon: Icon(Icons.location_on),
                    color: Colors.red,
                    iconSize: 45.0,
                    onPressed: () {
                      print('Marker tapped!');
                    },
                  ),
                ),
              ),
            ],
          ),
          // Tambahkan garis menghubungkan dua titik
          PolylineLayer(
            polylines: [
              Polyline(
                points: [
                  LatLng(-6.1754,
                      106.8272), // Koordinat titik 1 (Jakarta, Indonesia)
                  LatLng(-6.9175,
                      107.6191), // Koordinat titik 2 (Bandung, Indonesia)
                ],
                color: Colors.blue,
                strokeWidth: 3.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
