import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:frond_end_rental/models/package.dart';
import 'package:frond_end_rental/repositories/transaction_repository.dart';

part 'transaction_creation_event.dart';
part 'transaction_creation_state.dart';

class TransactionCreationBloc
    extends Bloc<TransactionCreationEvent, TransactionCreationState> {
  TransactionCreationBloc() : super(const TransactionCreationState()) {
    on<SelectPackage>((event, emit) {
      emit(state.copyWith(package: event.package));
    });
    on<SelectPaymentMethod>((event, emit) {
      emit(state.copyWith(paymentMethod: event.method));
    });
    on<SelectBike>((event, emit) {
      emit(state.copyWith(
        bike: event.selected,
        status: CreationStatus.bikeSelected,
      ));
    });

    on<LoadingCreation>((event, emit) {
      emit(state.copyWith(status: CreationStatus.loading));
    });

    on<SubmitCreation>(_onCreateOrder);
  }

  _onCreateOrder(
    SubmitCreation event,
    Emitter<TransactionCreationState> emit,
  ) async {
    try {
      final response =
          await TransactionRepository.createTransaction(state.toMap());
      emit(state.copyWith(
        status: CreationStatus.success,
        activeId: response,
      ));
    } on DioException catch (_) {
      emit(state.copyWith(status: CreationStatus.failed));
    }
  }
}
