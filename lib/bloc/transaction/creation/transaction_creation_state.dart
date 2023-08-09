part of 'transaction_creation_bloc.dart';

enum CreationStatus { loading, failed, success, initial, bikeSelected }

final class TransactionCreationState extends Equatable {
  final CreationStatus status;
  final int? bike;
  final String? paymentMethod;
  final Package? package;
  final int? activeId;
  final String? error;

  const TransactionCreationState({
    this.error,
    this.bike,
    this.package,
    this.paymentMethod,
    this.activeId,
    this.status = CreationStatus.initial,
  });

  TransactionCreationState copyWith({
    int? bike,
    Package? package,
    String? paymentMethod,
    int? activeId,
    CreationStatus? status,
    String? error,
  }) {
    return TransactionCreationState(
      bike: bike ?? this.bike,
      package: package ?? this.package,
      status: status ?? this.status,
      activeId: activeId ?? this.activeId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'payment_method': paymentMethod,
      'bike': bike!,
      'packages': package?.id
    };
  }

  @override
  List<Object?> get props =>
      [bike, package, paymentMethod, status, activeId, error];
}
