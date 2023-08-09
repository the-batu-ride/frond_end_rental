part of 'transaction_bloc.dart';

enum TransactionStatus { initial, success, failed }

final class TransactionState extends Equatable {
  final bool hasMore;
  final TransactionStatus status;
  final List<Transaction> transactions;

  const TransactionState({
    this.hasMore = true,
    this.status = TransactionStatus.initial,
    this.transactions = const <Transaction>[],
  });

  TransactionState copyWith({
    TransactionStatus? status,
    bool? hasMore,
    List<Transaction>? transactions,
  }) =>
      TransactionState(
        status: status ?? this.status,
        hasMore: hasMore ?? this.hasMore,
        transactions: transactions ?? this.transactions,
      );

  @override
  List<Object> get props => [hasMore, status, transactions];
}
