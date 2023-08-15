import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frond_end_rental/bloc/package/package_bloc.dart';
import 'package:frond_end_rental/bloc/transaction/creation/transaction_creation_bloc.dart';
import 'package:frond_end_rental/models/package.dart';
import 'package:frond_end_rental/utils/auth_util.dart'
    show showGeneralError, showSuccessMessage;
import 'package:frond_end_rental/utils/security.dart';
import 'package:frond_end_rental/widget/buttons.dart';
import 'package:frond_end_rental/widget/inputs.dart';
import 'package:frond_end_rental/widget/loader.dart' show CenterLoader;
import 'package:go_router/go_router.dart';

class PakcageBottomSheet extends StatelessWidget {
  const PakcageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      height: 380,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 11),
                child: Text(
                  'Package Route',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Divider(
              color: Color.fromARGB(255, 210, 210, 210),
              height: 0.1,
            ),
            const Padding(
              padding: EdgeInsets.all(25),
              child: Text(
                'Today - Senin, 24 Juli 2023',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 25,
                left: 25,
                bottom: 25,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.09),
                      offset: Offset(0, 1),
                      blurRadius: 1,
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: BlocBuilder<PackageBloc, PackageState>(
                        builder: (context, package) {
                          return BlocSelector<TransactionCreationBloc,
                              TransactionCreationState, Package?>(
                            selector: (state) => state.package,
                            builder: (context, state) {
                              return GeneralInput(
                                customInput: Row(
                                  children: [
                                    const SizedBox(width: 15),
                                    SizedBox(
                                      width: size.width - 140,
                                      child: DropdownSearch<Package>(
                                        dropdownDecoratorProps:
                                            const DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                            hintText: 'Choose Package',
                                            border: InputBorder.none,
                                          ),
                                        ),
                                        items: package.packages,
                                        selectedItem: state,
                                        onChanged: (value) => context
                                            .read<TransactionCreationBloc>()
                                            .add(SelectPackage(package: value)),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 20,
                        left: 20,
                        bottom: 20,
                      ),
                      child: GeneralInput(
                        customInput: BlocSelector<TransactionCreationBloc,
                            TransactionCreationState, String?>(
                          selector: (state) => state.paymentMethod,
                          builder: (context, state) {
                            return Row(
                              children: [
                                const SizedBox(width: 15),
                                SizedBox(
                                  width: size.width - 140,
                                  child: DropdownButton(
                                    dropdownColor: Colors.white,
                                    hint: const Text('Choose Payment Method'),
                                    isExpanded: true,
                                    underline: const SizedBox(),
                                    items: paymentMethodsMapping(),
                                    value: state,
                                    onChanged: (value) {
                                      context
                                          .read<TransactionCreationBloc>()
                                          .add(
                                            SelectPaymentMethod(method: value),
                                          );
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    BlocBuilder<TransactionCreationBloc,
                        TransactionCreationState>(
                      builder: (context, state) {
                        return BlocListener<TransactionCreationBloc,
                            TransactionCreationState>(
                          listener: (context, state) {
                            if (state.status == CreationStatus.success &&
                                state.activeId != null) {
                              showSuccessMessage(
                                context,
                                'Sukses membuat pesanan',
                              );
                              Navigator.pop(context);
                              context.goNamed('verification', pathParameters: {
                                'code': encryptId(state.activeId!)
                              });
                            } else if (state.status == CreationStatus.failed) {
                              showGeneralError(
                                context,
                                'error',
                              );
                              Navigator.pop(context);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 20,
                              left: 20,
                              bottom: 20,
                            ),
                            child: ButtonSolid(
                              sizes: size,
                              text: 'Next',
                              child: state.status == CreationStatus.loading
                                  ? const Padding(
                                      padding: EdgeInsets.all(2),
                                      child: CenterLoader(color: Colors.white),
                                    )
                                  : null,
                              handler: () {
                                if (state.bike == null) {
                                  showGeneralError(
                                    context,
                                    'Scan sepeda terlebih dahulu',
                                  );
                                  Navigator.pop(context);
                                  return;
                                }

                                context.read<TransactionCreationBloc>()
                                  ..add(LoadingCreation())
                                  ..add(SubmitCreation());
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> paymentMethodsMapping() {
    return ['Cash', 'Bank Transfer']
        .map((value) => DropdownMenuItem(
              value: value.split(' ').join('_').toUpperCase(),
              child: Text(value),
            ))
        .toList();
  }
}
