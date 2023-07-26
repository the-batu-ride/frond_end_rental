import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frond_end_rental/constant/colors.dart';
import 'package:frond_end_rental/screens/daftar.dart';
import 'package:frond_end_rental/utils/auth_uril.dart';

import '../constant/conection.dart';
import '../models/login_model.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void initState() {
    getToken().then((value) {
      if (value != null) {
        Navigator.of(context).pushReplacementNamed('/home');
        return;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> loginClick() async {
      Dio dio = Dio();
      var url = "${apiConnection}api/v1/auth/signin";
      LoginModel datalogin = LoginModel(
        email: email.text,
        password: password.text,
      );

      try {
        final storage = await getStorage();
        final header = {'Content-type': 'application/json'};
        final response = await dio.post(
          url,
          data: datalogin.toMap(),
          options: Options(headers: header),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          storage.setString('token', response.data['data']['access_token']);
          if (context.mounted) {
            Navigator.of(context).pushReplacementNamed('/home');
          }
          return;
        }
      } on DioException catch (_) {
        if (context.mounted) {
          showGeneralError(context, 'Username/password salah');
        }
      }
    }

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: lightGreyColor,
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              './assets/images/logo-remove.png',
              width: size.width * .4,
              height: size.height * .2,
            ),
            const Text(
              "Login",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(height: 10),
            Container(
              margin: EdgeInsets.all(size.width * .09),
              child: Column(
                children: [
                  TextField(
                    controller: email,
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  TextField(
                    controller: password,
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
                  const SizedBox(height: 5),
                  Container(
                    width: size.width * 9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
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
                            "Register Now",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: greenPrimary),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontSize: 12,
                              color: mediumGreyColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * .059,
                    child: ElevatedButton(
                      onPressed: loginClick,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: greenPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      child: const Text(
                        "MASUK",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: whiteColor,
                        ),
                      ),
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
