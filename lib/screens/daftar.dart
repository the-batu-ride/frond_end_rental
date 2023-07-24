import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frond_end_rental/constant/conection.dart';
import 'package:frond_end_rental/models/register_model.dart';
import '../constant/colors.dart';

class Daftar extends StatelessWidget {
  Daftar({super.key});

  final emailText = TextEditingController();
  final firstName = TextEditingController();
  final lastname = TextEditingController();
  final alamat = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  Future<void> daftarClick(BuildContext context) async {
    if (password.text != confirmPassword.text) {
      return;
    }

    Dio dio = Dio();
    var url = "${apiConnection}api/v1/auth";
    final data = RegisterModel(
      email: emailText.text,
      adress: alamat.text,
      firstName: firstName.text,
      lastName: lastname.text,
      password: password.text,
    );

    var header = {'Content-type': 'application/json'};
    var response = await dio.post(
      url,
      data: data.toMap(),
      options: Options(headers: header),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: greyColor,
        width: size.width,
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(size.width * 0.1),
                  width: size.height * 0.2,
                  height: size.height * 0.2,
                  color: Colors.grey,
                ),
                const Text(
                  "Register Now",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const Text(
                  "Create an account",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: size.width * 0.8,
                  margin: EdgeInsets.all(size.width * 0.1),
                  child: Container(
                    margin: EdgeInsets.all(size.width * 0.05),
                    child: Column(children: [
                      TextField(
                        controller: emailText,
                        decoration: const InputDecoration(
                          labelText: "E-Mail",
                          hintText: "Your e-mail",
                        ),
                      ),
                      TextField(
                        controller: firstName,
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                          hintText: "First Name",
                        ),
                      ),
                      TextField(
                        controller: lastname,
                        decoration: const InputDecoration(
                          labelText: 'Last Name',
                          hintText: "Last Name",
                        ),
                      ),
                      TextField(
                        controller: alamat,
                        decoration: const InputDecoration(
                          labelText: 'Adress',
                          hintText: "Adress",
                        ),
                      ),
                      TextField(
                        obscureText: true,
                        controller: password,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          hintText: "Password",
                        ),
                      ),
                      TextField(
                        obscureText: true,
                        controller: confirmPassword,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          hintText: "Confirm Password",
                        ),
                      )
                    ]),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: size.width * 0.05,
                    right: size.width * 0.05,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: size.width * 0.05,
                    right: size.width * 0.05,
                    bottom: size.width * 0.05,
                  ),
                  width: size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      daftarClick(context);
                    },
                    child: Text("Daftar"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
