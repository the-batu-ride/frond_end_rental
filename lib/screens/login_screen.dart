import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frond_end_rental/constant/colors.dart';
import 'package:frond_end_rental/screens/daftar.dart';

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
        color: mediumGreyColor,
        width: size.width,
        height: size.height,
        child: Center(
          child: Container(
            alignment: Alignment.center,
            width: size.width * .8,
            height: size.height * .8,
            decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
                ),
                const SizedBox(height: 40),
                Container(
                  margin: EdgeInsets.all(size.width * .09),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: "No Telfon",
                          hintText: "No Telfon",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * .059,
                        child: ElevatedButton(
                          onPressed: () {
                            loginClick();
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  18.0), // Adjust the value as needed
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Belum Punya Akun?",
                            style: TextStyle(fontSize: 12),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Daftar(),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: const Text(
                              "Daftar",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
