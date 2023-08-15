import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:frond_end_rental/models/transaction.dart';
import 'package:frond_end_rental/repositories/transaction_repository.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  /// bloc
  TransactionBloc() : super(const TransactionState()) {
    on<TransactionFetched>(
      _onTransactionFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  _onTransactionFetched(
    TransactionFetched event,
    Emitter<TransactionState> emit,
  ) async {
    try {
      if (state.hasMore) {
        final start = state.transactions.length;
        final response = await TransactionRepository.getTransactions(start);

        if (response.isEmpty) {
          emit(state.copyWith(
              status: TransactionStatus.success, hasMore: false));
          return;
        }

        if (response.length < 10) {
          emit(state.copyWith(
            transactions: List.of(state.transactions)..addAll(response),
            status: TransactionStatus.success,
            hasMore: false,
          ));
          return;
        }

        emit(state.copyWith(
          transactions: List.of(state.transactions)..addAll(response),
          status: TransactionStatus.success,
        ));
      }
    } on DioException catch (_) {
      emit(state.copyWith(status: TransactionStatus.failed));
    }
  }
}
