import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frond_end_rental/constant/conection.dart';
import 'package:frond_end_rental/utils/auth_uril.dart';
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
  List<dynamic> list = [];

  void getHistoryTransaction() async {
    final token = await getToken();
    final response = await client.get<Map<String, dynamic>>(
      '${apiConnection}api/v1/transaction',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    final data = response.data!['data'] as List<dynamic>;
    setState(() {
      list = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getToken().then((value) {
      if (value == null) {
        showUnAuthorizedError(context);
        Navigator.of(context).pushReplacementNamed('/');
        return;
      }
      getHistoryTransaction();
    });
  }

  List<Widget> renderCards(Size size) {
    return list
        .map(
          (e) => cardListTransaksi(
            context,
            size: size,
            nameTransaksi: e['package']['name'],
            price: e['package']['price'].toString(),
            status: e['status'],
            package: e['package'],
            data: e,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: lightGreyColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        leading: Builder(
          builder: (cont) => GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Ionicons.chevron_back_outline,
              color: purpleChat,
            ),
          ),
        ),
        title: const Center(
          child: Text(
            "Transactions",
            style: TextStyle(
              color: blackColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(
        //       Ionicons.notifications_outline,
        //       color: purpleChat,
        //     ),
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            width: size.width * .9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 7,
                ),
                const Text(
                  "Today",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 7,
                ),
                ...renderCards(size),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: bottomMenu(
        onQrResolve: (dataQr) {},
        toTrans: () {},
      ),
    );
  }
}
