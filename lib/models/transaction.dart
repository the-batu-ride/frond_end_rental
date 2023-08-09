import 'package:equatable/equatable.dart';
import 'package:frond_end_rental/models/package.dart';

final class Transaction extends Equatable {
  final int id, bike;
  final String code, status, updatedAt, createdAt;
  final String? bill;
  final Customer customer;
  final Package package;

  bool get isPaid => bill != null;
  bool get isApproved => status == 'APPROVED';
  bool get isRejected => status == 'REJECTED';
  bool get isPending => status == 'PENDING';
  bool get isCompleted => status == 'COMPLETED';

  const Transaction({
    required this.id,
    required this.bike,
    required this.code,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
    required this.customer,
    required this.package,
    required this.bill,
  });

  @override
  List<Object?> get props => [
        id,
        bike,
        code,
        status,
        updatedAt,
        createdAt,
        customer,
        package,
        bill,
      ];

  factory Transaction.fromJson(dynamic json) {
    final package = Package.fromJson(json['package']);
    final customer = Customer.fromJson(json['customer']);

    return Transaction(
        id: json['id'],
        code: json['code'],
        status: json['status'],
        updatedAt: json['updated_at'],
        createdAt: json['created_at'],
        customer: customer,
        package: package,
        bike: json['bike']['id'],
        bill: json['payment']['payment_bill']);
  }

  Transaction copyWith({
    int? id,
    int? bike,
    String? code,
    String? status,
    String? updatedAt,
    String? createdAt,
    String? bill,
    Customer? customer,
    Package? package,
  }) {
    return Transaction(
      id: id ?? this.id,
      bike: bike ?? this.bike,
      code: code ?? this.code,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      bill: bill ?? this.bill,
      customer: customer ?? this.customer,
      package: package ?? this.package,
    );
  }
}

final class Customer extends Equatable {
  final int id;
  final String fullName;
  final String role;

  const Customer({
    required this.id,
    required this.fullName,
    required this.role,
  });

  factory Customer.fromJson(dynamic json) => Customer(
        id: json['id'],
        fullName: json['full_name'],
        role: json['role'],
      );

  @override
  List<Object?> get props => [id, fullName, role];
}
