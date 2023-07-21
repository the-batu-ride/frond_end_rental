import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frond_end_rental/constant/conection.dart';
import 'package:frond_end_rental/models/register_model.dart';
import 'constant/colors.dart';

class daftar extends StatelessWidget {
  @override
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastname = TextEditingController();
  final alamat = TextEditingController();
  final password = TextEditingController();
  final confirm_password = TextEditingController();

  Future<void> daftarClick(BuildContext context) async {
    if (password.text != confirm_password.text) {
      return;
    }

    Dio dio = Dio();
    var url = apiConnection + "api/v1/auth";
    RegisterModel data = RegisterModel(
      email: email.text,
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

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          color: greyColor,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin:
                        EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
                    width: MediaQuery.of(context).size.height * 0.2,
                    height: MediaQuery.of(context).size.height * 0.2,
                    color: Colors.grey,
                  ),
                  Text(
                    "Register Now",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text("Create an account",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin:
                        EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
                    child: Container(
                      margin: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.05),
                      child: Column(children: [
                        TextField(
                          controller: email,
                          decoration: InputDecoration(
                              labelText: "E-Mail", hintText: "Your e-mail"),
                        ),
                        TextField(
                            controller: firstName,
                            decoration: InputDecoration(
                                labelText: 'First Name',
                                hintText: "First Name")),
                        TextField(
                            controller: lastname,
                            decoration: InputDecoration(
                                labelText: 'Last Name', hintText: "Last Name")),
                        TextField(
                          controller: alamat,
                          decoration: InputDecoration(
                              labelText: 'Adress', hintText: "Adress"),
                        ),
                        TextField(
                          obscureText: true,
                          controller: password,
                          decoration: InputDecoration(
                              labelText: 'Password', hintText: "Password"),
                        ),
                        TextField(
                          obscureText: true,
                          controller: confirm_password,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            hintText: "Confirm Password",
                          ),
                        )
                      ]),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                        bottom: MediaQuery.of(context).size.width * 0.05),
                    width: MediaQuery.of(context).size.width,
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
      ),
    );
  }
}
