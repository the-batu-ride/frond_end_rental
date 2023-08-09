import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frond_end_rental/bloc/auth/auth_bloc.dart';
import 'package:frond_end_rental/bloc/transaction/list/transaction_bloc.dart';
import 'package:frond_end_rental/widget/loader.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../constant/colors.dart';
import '../widget/bottom_menu.dart';
import '../widget/card_list_transaksi.dart';

class ListTransaksi extends StatefulWidget {
  const ListTransaksi({super.key});

  @override
  State<ListTransaksi> createState() => _ListTransaksiState();
}

class _ListTransaksiState extends State<ListTransaksi> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>()
      ..add(AuthChecking())
      ..add(CheckStatus());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<TransactionBloc>().add(TransactionFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: lightGreyColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        leading: Builder(
          builder: (cont) => GestureDetector(
            onTap: () => context.goNamed('home'),
            child: const Icon(
              Ionicons.chevron_back_outline,
              color: blackColor,
            ),
          ),
        ),
        title: const Center(
          child: Text(
            'Transactions',
            style: TextStyle(
              color: blackColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is SignedIn) {
            return BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                switch (state.status) {
                  case TransactionStatus.success:
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: state.hasMore
                          ? state.transactions.length + 1
                          : state.transactions.length,
                      itemBuilder: (context, index) =>
                          index >= state.transactions.length
                              ? const BottomLoader()
                              : CardHistory(
                                  data: state.transactions[index],
                                  size: size,
                                ),
                    );
                  case TransactionStatus.failed:
                    return const Center(
                      child: Text('Terjadi kesalahan saat mengambil data'),
                    );
                  default:
                    return const Center(
                      child: SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(strokeWidth: 3),
                      ),
                    );
                }
              },
            );
          }

          return const Center(
            child: SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomMenu(),
    );
  }
}
