import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../constant/conection.dart';
import '../models/login_model.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final password = TextEditingController();
    Future<void> loginClick() async {
      Dio dio = Dio();
      var url = "${apiConnection}api/v1/auth/signin";
      LoginModel datalogin = LoginModel(
        email: email.text,
        password: password.text,
      );

      final storage = await getStorage();
      final header = {'Content-type': 'application/json'};
      final response = await dio.post(
        url,
        data: datalogin.toMap(),
        options: Options(headers: header),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        storage.setString('token', response.data['data']['access_token']);
      }
    }

    void daftarClick(BuildContext context) {
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed('/daftar');
      }
    }

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(size.width * 0.1),
              width: size.height * 0.2,
              height: size.height * 0.2,
              color: Colors.grey,
            ),
            const Text("Login"),
            const Text("Silahkan Login terlebih dahulu"),
            Container(
              margin: EdgeInsets.all(size.width * 0.1),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: "No Handphone",
                      hintText: "Masukan No Hp Anda",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter Name',
                      hintText: "Masukan Password Anda",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                        bottom: MediaQuery.of(context).size.width * 0.05),
                    width: MediaQuery.of(context).size.width * .9,
                    child: ElevatedButton(
                      onPressed: () {
                        loginClick();
                      },
                      child: Text("Login"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
