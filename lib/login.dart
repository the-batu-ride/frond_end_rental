import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frond_end_rental/constant/colors.dart';
import 'package:frond_end_rental/constant/conection.dart';
import 'package:frond_end_rental/models/login_model.dart';

class login extends StatelessWidget {
  const login({super.key});

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

    return Scaffold(
      body: Container(
          color: greyColor,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
                width: MediaQuery.of(context).size.height * 0.2,
                height: MediaQuery.of(context).size.height * 0.2,
                color: Colors.grey,
              ),
              const Text(
                "Login",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const Text(
                "Silahkan Login terlebih dahulu",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                width: MediaQuery.of(context).size.width * 0.8,
                margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
                child: Container(
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                  child: Column(children: [
                    TextField(
                      controller: email,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email",
                          hintText: "Masukan Email Anda"),
                    ),
                    TextField(
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: "Masukan Password Anda"))
                  ]),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          daftarClick(context);
                        },
                        child: Text("Register Now")),
                    Text("Forgot Password?")
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                      bottom: MediaQuery.of(context).size.width * 0.05),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        loginClick();
                      },
                      child: Text("Login")))
            ],
          )),
    );
  }
}
