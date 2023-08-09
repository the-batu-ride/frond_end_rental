part of 'payment_bloc.dart';

enum PaymentStatus { initial, success, error, loaded, loading }

final class PaymentState extends Equatable {
  final PaymentStatus status;
  final Transaction? transaction;
  final Uint8List? bynary;
  final String? name;
  final String? error;

  const PaymentState(
      {this.status = PaymentStatus.initial,
      this.transaction,
      this.bynary,
      this.name,
      this.error});

  PaymentState copyWith({
    PaymentStatus? status,
    Transaction? transaction,
    Uint8List? bynary,
    String? name,
    String? error,
  }) =>
      PaymentState(
          status: status ?? this.status,
          transaction: transaction ?? this.transaction,
          bynary: bynary ?? this.bynary,
          name: name ?? this.name,
          error: error ?? this.error);

  @override
  List<Object?> get props => [status, transaction, name, bynary, error];
}
