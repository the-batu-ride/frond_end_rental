import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frond_end_rental/bloc/auth/auth_bloc.dart';
import 'package:frond_end_rental/bloc/payment/payment_bloc.dart';
import 'package:frond_end_rental/constant/colors.dart';
import 'package:frond_end_rental/utils/format.dart'
    show formatDate, formatRupiah;
import 'package:frond_end_rental/utils/security.dart';
import 'package:frond_end_rental/widget/appbar_custom.dart';
import 'package:frond_end_rental/widget/bottom_menu.dart';
import 'package:frond_end_rental/widget/loader.dart' show CenterLoader;
import 'package:ionicons/ionicons.dart' show Ionicons;

class TransactionDetail extends StatefulWidget {
  final String code;

  const TransactionDetail({super.key, required this.code});

  @override
  State<TransactionDetail> createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  @override
  void initState() {
    super.initState();
    context.read<PaymentBloc>().add(Load(decryptId(widget.code)));
  }

  SizedBox marginItem(Size size) {
    return SizedBox(
      height: size.height * 0.02,
    );
  }

  Widget renderDevider(Color color) {
    return Divider(
      color: color,
      height: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarCustom(
        'Transaction Detail',
        Icons.delete,
        context,
        path: 'history',
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is SignedIn) {
            return BlocBuilder<PaymentBloc, PaymentState>(
              builder: (context, state) {
                if (state.status == PaymentStatus.initial) {
                  return const CenterLoader();
                }

                if (state.status == PaymentStatus.error) {
                  return Center(
                    child: Text(state.error ?? 'Terjadi kesalahan'),
                  );
                }

                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          width: size.height * 0.10,
                          height: size.height * 0.10,
                          decoration: BoxDecoration(
                            color: greenPrimary,
                            borderRadius: BorderRadius.all(
                              Radius.circular(size.height * 0.10),
                            ),
                          ),
                          child: const Icon(
                            size: 78,
                            Ionicons.checkmark_circle,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          state.transaction!.isCompleted
                              ? 'Succesfully'
                              : 'Failed',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: size.height * 0.10,
                            right: size.height * 0.10,
                            top: size.height * 0.05,
                          ),
                          child: Column(
                            children: [
                              ItemDetail(
                                title: 'Status',
                                data: state.transaction!.isCompleted
                                    ? 'Success'
                                    : 'Failed',
                              ),
                              renderDevider(Colors.grey),
                              marginItem(size),
                              ItemDetail(
                                title: 'Cust',
                                data: state.transaction!.customer.fullName,
                              ),
                              renderDevider(Colors.grey),
                              marginItem(size),
                              ItemDetail(
                                title: 'Paket',
                                data: state.transaction!.package.name,
                              ),
                              renderDevider(Colors.grey),
                              marginItem(size),
                              ItemDetail(
                                title: 'Cash',
                                data:
                                    state.transaction!.bill?.contains('cash') ??
                                            false
                                        ? 'Yes'
                                        : 'No',
                              ),
                              renderDevider(Colors.grey),
                              marginItem(size),
                              ItemDetail(
                                title: 'Date',
                                data: formatDate(
                                  DateTime.parse(
                                    state.transaction!.updatedAt,
                                  ),
                                ),
                              ),
                              renderDevider(Colors.grey),
                              marginItem(size),
                              ItemDetail(
                                title: 'Amount',
                                data: formatRupiah(
                                  double.parse(
                                    state.transaction!.package.price,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const CenterLoader();
        },
      ),
      bottomNavigationBar: const BottomMenu(),
    );
  }
}

class ItemDetail extends StatelessWidget {
  final String data;
  final String title;

  const ItemDetail({super.key, required this.data, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          data,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
