import 'package:equatable/equatable.dart';

class Bike extends Equatable {
  final int id;
  final String code;
  final String name;
  final bool available;
  final String image;

  const Bike({
    required this.id,
    required this.code,
    required this.name,
    required this.available,
    required this.image,
  });

  @override
  List<Object?> get props => [id, code, name, available, image];

  factory Bike.fromJson(Map<String, dynamic> json) {
    return Bike(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      available: json['available'],
      image: json['image'],
    );
  }
}
