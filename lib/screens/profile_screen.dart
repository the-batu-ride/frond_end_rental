import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frond_end_rental/constant/colors.dart';
import 'package:frond_end_rental/constant/conection.dart';
import 'package:frond_end_rental/provider/transaction_provider.dart';
import 'package:frond_end_rental/utils/security.dart';
import 'package:frond_end_rental/widget/appbar_custom.dart';
import 'package:frond_end_rental/widget/bottom_menu.dart';
import 'package:frond_end_rental/widget/route_bottom_sheet.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
//dummy data
    var emailDummy = "samsul@gmail.com";
    var firstnameDummy = "samsul";
    var lastnameDummy = "sam";
    var alamatDummy = "malang";
    var passwordDummy = "password";

    final emailText = TextEditingController(text: emailDummy);
    final firstName = TextEditingController(text: firstnameDummy);
    final lastname = TextEditingController(text: lastnameDummy);
    final alamat = TextEditingController(text: alamatDummy);
    final password = TextEditingController(text: passwordDummy);
    final confirmPassword = TextEditingController();

    Future<void> saveClick() async {}

    return (Scaffold(
      appBar: AppBarCustom(
        'Profile',
        Icons.notifications,
        context,
        path: '/home',
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(children: [
            TextField(
              controller: emailText,
              decoration: InputDecoration(
                labelText: "E-Mail",
                hintText: "Your e-mail",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: firstName,
              decoration: InputDecoration(
                labelText: 'First Name',
                hintText: "First Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: lastname,
              decoration: InputDecoration(
                labelText: 'Last Name',
                hintText: "Last Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: alamat,
              decoration: InputDecoration(
                labelText: 'Adress',
                hintText: "Adress",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              obscureText: true,
              controller: password,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              obscureText: true,
              controller: confirmPassword,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                hintText: "Confirm Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 2000,
              child: ElevatedButton(
                onPressed: () {
                  saveClick();
                },
                child: Text("Save"),
                style: ElevatedButton.styleFrom(primary: primaryColor),
              ),
            )
          ]),
        ),
      ),
      bottomNavigationBar: bottomMenu(
        context: context,
        onQrResolve: (dataQr) async {
          final newId = dataQr!.replaceFirst(RegExp('Code scanned = '), '');
          final id = encryptId(int.parse(newId));
          setCurrentBike(int.parse(newId));
          final token = await getToken();
          final response = await client.get(
            '${apiConnection}api/v1/bike/$id',
            options: Options(headers: {'Authorization': 'Bearer $token'}),
          );

          if (context.mounted) {
            context
                .read<TransactionProvider>()
                .setBike(response.data['data']['id']);

            showModalBottomSheet(
              context: context,
              builder: (ctx) => const PakcageBottomSheet(),
            );
          }
        },
      ),
    ));
  }
}
