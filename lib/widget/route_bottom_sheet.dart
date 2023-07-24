import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frond_end_rental/constant/conection.dart';

class PakcageBottomSheet extends StatefulWidget {
  const PakcageBottomSheet({super.key});

  @override
  State<PakcageBottomSheet> createState() => _PakcageBottomSheetState();
}

class _PakcageBottomSheetState extends State<PakcageBottomSheet> {
  List<dynamic> packages = [];
  bool isLoading = true;

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
    } on DioException catch (e) {
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
    return SizedBox(
      height: 500,
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [],
            ),
    );
  }
}
