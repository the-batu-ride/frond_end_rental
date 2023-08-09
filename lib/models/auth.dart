import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String name;
  final String address;
  final String email;
  final int id;

  const AuthEntity({
    required this.name,
    required this.address,
    required this.email,
    required this.id,
  });

  @override
  List<Object?> get props => [id, name, email, address];

  factory AuthEntity.fromJson(dynamic json) => AuthEntity(
        name: json['full_name'],
        address: json['address'],
        email: json['email'],
        id: json['id'],
      );
}
