import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frond_end_rental/constant/colors.dart';
import 'package:frond_end_rental/constant/conection.dart';
import 'package:frond_end_rental/models/register_model.dart';
import 'package:frond_end_rental/provider/transaction_provider.dart';
import 'package:frond_end_rental/utils/auth_uril.dart';
import 'package:frond_end_rental/utils/security.dart';
import 'package:frond_end_rental/widget/appbar_custom.dart';
import 'package:frond_end_rental/widget/bottom_menu.dart';
import 'package:frond_end_rental/widget/route_bottom_sheet.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  dynamic data;

  final emailText = TextEditingController();
  final firstName = TextEditingController();
  final lastname = TextEditingController();
  final alamat = TextEditingController();
  final password = TextEditingController(text: 'defaultt');
  final confirmPassword = TextEditingController(text: 'defaultt');

  @override
  void initState() {
    get(context);
    super.initState();
  }

  Future<void> get(BuildContext context) async {
    try {
      final token = await getToken();
      final response = await client.get('${apiConnection}api/v1/auth/user',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      setState(() {
        data = response.data['data'];
        emailText.text = response.data['data']['email'];
        firstName.text =
            (response.data['data']['full_name'] as String).split(" ")[0];
        lastname.text =
            (response.data['data']['full_name'] as String).split(" ")[1];
        alamat.text = response.data['data']['address'];
      });
    } on DioException catch (_) {
      showGeneralError(context, 'Gagal mengambil data');
    }
  }

  @override
  Widget build(BuildContext context) {
//dummy data

    Future<void> saveClick() async {
      try {
        final token = await getToken();
        final payload = RegisterModel(
          email: emailText.text,
          adress: alamat.text,
          firstName: firstName.text,
          lastName: lastname.text,
          password: password.text,
        );
        final id = encryptId(data['id']);

        await client.put(
          '${apiConnection}api/v1/auth/$id',
          data: payload.toMap(),
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );

        if (context.mounted) {
          showSuccessMessage(context, 'Berhasil memperbarui profil');
        }
      } on DioException catch (_) {
        showGeneralError(context, 'Gagal memperbarui profil');
      }
    }

    return (Scaffold(
      appBar: AppBarCustom(
        'Profile',
        null,
        context,
        path: '/home',
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 25,
            horizontal: 30,
          ),
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Text(
                  'Update Profile',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
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
            const SizedBox(height: 25),
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
            const SizedBox(height: 25),
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
            const SizedBox(height: 25),
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
            const SizedBox(height: 25),
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
            const SizedBox(height: 25),
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
            const SizedBox(height: 25),
            SizedBox(
              width: MediaQuery.of(context).size.width - 70,
              child: ElevatedButton(
                onPressed: saveClick,
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                child: const Text("Save"),
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
