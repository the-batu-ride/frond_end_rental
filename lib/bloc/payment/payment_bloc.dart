import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:frond_end_rental/models/transaction.dart';
import 'package:frond_end_rental/repositories/transaction_repository.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(const PaymentState()) {
    on<Load>(_onLoadTransaction);
    on<UploadPayment>(_onUploadPayment);
    on<SavePayment>(_onSavePayment);
    on<UpdateStatus>(_onUpdateStatus);
  }

  _onLoadTransaction(Load event, Emitter<PaymentState> emit) async {
    try {
      final response = await TransactionRepository.getTransaction(event.id);
      emit(state.copyWith(
        transaction: response,
        status: PaymentStatus.loaded,
      ));
    } on DioException catch (_) {
      emit(state.copyWith(
        status: PaymentStatus.error,
        error: 'Terjadi kesalahan saat mengambil data!',
      ));
    }
  }

  _onUploadPayment(UploadPayment event, Emitter<PaymentState> emit) {
    emit(state.copyWith(bynary: event.bynary, name: event.name));
  }

  _onSavePayment(SavePayment event, Emitter<PaymentState> emit) async {
    try {
      await TransactionRepository.uploadTransferBill(
        {'name': state.name, 'binary': state.bynary},
        state.transaction!.id,
      );
      emit(
        state.copyWith(
          status: PaymentStatus.success,
          transaction: state.transaction?.copyWith(bill: 'success added'),
        ),
      );
    } on DioException catch (_) {
      emit(state.copyWith(
        status: PaymentStatus.error,
        error: 'Terjadi kesalah mohon coba beberapa saat lagi!',
      ));
    }
  }

  _onUpdateStatus(UpdateStatus event, Emitter<PaymentState> emit) {
    if (event.code == state.transaction?.code && event.status == 'APPROVED') {
      emit(state.copyWith(
        transaction: state.transaction?.copyWith(status: 'APPROVED'),
      ));
    }

    if (event.code == state.transaction?.code && event.status == 'REJECTED') {
      emit(state.copyWith(
        transaction: state.transaction?.copyWith(status: 'REJECTED'),
      ));
    }
  }
}
