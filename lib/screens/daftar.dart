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
                  "Register",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
                ),
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: size.width * 0.8,
                  margin: EdgeInsets.all(size.width * 0.01),
                  child: Container(
                    margin: EdgeInsets.all(size.width * 0.05),
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
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 10),
                    ]),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: size.width * 0.05,
                    right: size.width * 0.05,
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  width: MediaQuery.of(context).size.width * .7,
                  height: MediaQuery.of(context).size.height * .059,
                  child: ElevatedButton(
                    onPressed: () {
                      daftarClick(context);
                    },
                    child: Text(
                      "Register",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            18.0), // Adjust the value as needed
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
