import 'package:equatable/equatable.dart';

final class Package extends Equatable {
  final int id;
  final String code;
  final String name;
  final String description;
  final String price;
  final String latStart;
  final String lngStart;
  final String latDestination;
  final String lngDestination;
  final List<Point> points;

  @override
  List<Object?> get props => [
        id,
        code,
        name,
        description,
        price,
        latStart,
        lngStart,
        latDestination,
        lngDestination,
        points
      ];

  const Package({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.price,
    required this.latStart,
    required this.lngStart,
    required this.latDestination,
    required this.lngDestination,
    required this.points,
  });

  factory Package.fromJson(dynamic json) {
    return Package(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      latStart: json['lat_start'],
      lngStart: json['lngt_start'],
      latDestination: json['lat_destination'],
      lngDestination: json['lngt_destination'],
      points: json['points'] == null
          ? []
          : (json['points'] as List<dynamic>)
              .map((e) => Point.fromJson(e))
              .toList(),
    );
  }

  static List<Package> toModels(List<dynamic> list) =>
      list.map((e) => Package.fromJson(e)).toList();

  @override
  String toString() {
    return '$name - $price';
  }
}

class Point extends Equatable {
  final String title;
  final double lat;
  final double lng;

  const Point({
    required this.title,
    required this.lat,
    required this.lng,
  });

  @override
  List<Object?> get props => [title, lat, lng];

  factory Point.fromJson(dynamic json) => Point(
        title: json['title'],
        lat: double.parse(json['latitude']),
        lng: double.parse(json['longitude']),
      );
}
