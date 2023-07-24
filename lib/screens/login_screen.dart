import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.grey,
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
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              width: size.width * 0.8,
              margin: EdgeInsets.all(size.width * 0.1),
              child: Container(
                margin: EdgeInsets.all(size.width * 0.1),
                child: const Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: "No Handphone",
                        hintText: "Masukan No Hp Anda",
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Enter Name',
                        hintText: "Masukan Password Anda",
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
