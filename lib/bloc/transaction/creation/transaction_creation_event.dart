part of 'transaction_creation_bloc.dart';

abstract class TransactionCreationEvent extends Equatable {
  const TransactionCreationEvent();

  @override
  List<Object?> get props => [];
}

class SelectPackage extends TransactionCreationEvent {
  final Package? package;

  const SelectPackage({this.package});

  @override
  List<Object?> get props => [package];
}

class SelectBike extends TransactionCreationEvent {
  final int? selected;

  const SelectBike({required this.selected});

  @override
  List<Object?> get props => [selected];
}

class SelectPaymentMethod extends TransactionCreationEvent {
  final String? method;

  const SelectPaymentMethod({this.method});

  @override
  List<Object?> get props => [method];
}

class LoadingCreation extends TransactionCreationEvent {}

class SubmitCreation extends TransactionCreationEvent {}
