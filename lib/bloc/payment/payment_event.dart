part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class Load extends PaymentEvent {
  final int id;

  const Load(this.id);

  @override
  List<Object> get props => [id];
}

class UploadPayment extends PaymentEvent {
  final String name;
  final Uint8List bynary;

  const UploadPayment({
    required this.name,
    required this.bynary,
  });

  @override
  List<Object> get props => [name, bynary];
}

class SavePayment extends PaymentEvent {}

class UpdateStatus extends PaymentEvent {
  final String status;
  final String code;

  const UpdateStatus({
    required this.status,
    required this.code,
  });

  @override
  List<Object> get props => [status, code];
}
