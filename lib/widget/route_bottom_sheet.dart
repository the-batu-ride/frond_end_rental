import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:frond_end_rental/constant/conection.dart';
import 'package:frond_end_rental/models/package_model.dart';
import 'package:frond_end_rental/provider/transaction_provider.dart';
import 'package:frond_end_rental/widget/buttons.dart';
import 'package:frond_end_rental/widget/inputs.dart';
import 'package:provider/provider.dart';

class PakcageBottomSheet extends StatefulWidget {
  const PakcageBottomSheet({super.key});

  @override
  State<PakcageBottomSheet> createState() => _PakcageBottomSheetState();
}

class _PakcageBottomSheetState extends State<PakcageBottomSheet> {
  List<dynamic> packages = [];
  bool isLoading = true;
  String? paymentMethod;

  /// get packages
  Future<void> getPackages() async {
    const url = "${apiConnection}api/v1/package";

    try {
      final token = await getToken();
      final response = await client.get<Map<String, dynamic>>(
        url,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data!['data'] as List<dynamic>;
        setState(() {
          packages = data;
          isLoading = false;
        });
      }
    } on DioException catch (_) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getPackages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      height: 380,
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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
                            child: GeneralInput(
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
                                      items: Package.toModels(packages),
                                      onChanged: (value) {
                                        context
                                            .read<TransactionProvider>()
                                            .setPackage(value!.id);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 20,
                              left: 20,
                              bottom: 20,
                            ),
                            child: GeneralInput(
                              customInput: Row(
                                children: [
                                  const SizedBox(width: 15),
                                  SizedBox(
                                    width: size.width - 140,
                                    child: DropdownButton(
                                      dropdownColor: Colors.white,
                                      hint: const Text('Choose Payment Method'),
                                      isExpanded: true,
                                      underline: const SizedBox(),
                                      items: ['Cash', 'Bank Transfer']
                                          .map((value) {
                                        return DropdownMenuItem(
                                          value: value
                                              .split(" ")
                                              .join("_")
                                              .toUpperCase(),
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      value: context
                                          .watch<TransactionProvider>()
                                          .paymentMethod,
                                      onChanged: (value) {
                                        debugPrint(value);
                                        context
                                            .read<TransactionProvider>()
                                            .setPaymentMethod(value!);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 20,
                              left: 20,
                              bottom: 20,
                            ),
                            child: ButtonSolid(
                              handler: () async {
                                try {
                                  final provide =
                                      context.read<TransactionProvider>();
                                  final data = {
                                    'payment_method': provide.paymentMethod,
                                    'bike': provide.bike,
                                    'packages': provide.package
                                  };
                                  final token = await getToken();
                                  final response = await client.post(
                                      '${apiConnection}api/v1/transaction',
                                      data: data,
                                      options: Options(headers: {
                                        'Authorization': 'Bearer $token'
                                      }));

                                  if (response.statusCode == 201) {
                                    if (context.mounted) {
                                      if (provide.paymentMethod != "CASH") {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                          '/verification',
                                          arguments: response.data['data'],
                                        );
                                      } else {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                          '/map',
                                          arguments: response.data['data'],
                                        );
                                      }
                                    }
                                  }
                                } on DioException catch (e) {
                                  debugPrint(e.message);
                                }
                              },
                              sizes: size,
                              text: 'Next',
                            ),
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
}
