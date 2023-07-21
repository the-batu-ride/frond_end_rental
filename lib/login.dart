import 'package:flutter/material.dart';
import 'package:frond_end_rental/item/appbar_custom.dart';
import 'package:frond_end_rental/item/footer_custom.dart';

class login extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
            color: Colors.grey,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
                  width: MediaQuery.of(context).size.height * 0.2,
                  height: MediaQuery.of(context).size.height * 0.2,
                  color: Colors.grey,
                ),
                Text("Login"),
                Text("Silahkan Login terlebih dahulu"),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin:
                        EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
                    child: Container(
                      margin: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.1),
                      child: Column(children: [
                        TextField(
                          decoration: InputDecoration(
                              labelText: "No Handphone",
                              hintText: "Masukan No Hp Anda"
                              ),
                        ),
                        TextField(
                            decoration: InputDecoration(
                                labelText: 'Enter Name',
                                hintText: "Masukan Password Anda"))
                      ]),
                    ))
              ],
            )),
      );
}
