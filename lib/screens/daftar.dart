import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frond_end_rental/constant/conection.dart';
import 'package:frond_end_rental/models/register_model.dart';
import 'package:frond_end_rental/screens/login_screen.dart';
import 'package:frond_end_rental/utils/auth_uril.dart';
import '../constant/colors.dart';

class Daftar extends StatefulWidget {
  const Daftar({super.key});

  @override
  State<Daftar> createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
  bool loading = false;

  final emailText = TextEditingController();
  final firstName = TextEditingController();
  final lastname = TextEditingController();
  final alamat = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  void dispose() {
    emailText.dispose();
    firstName.dispose();
    lastname.dispose();
    alamat.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  bool validate(BuildContext context) {
    if (emailText.text.isEmpty ||
        firstName.text.isEmpty ||
        lastname.text.isEmpty ||
        alamat.text.isEmpty ||
        password.text.isEmpty ||
        confirmPassword.text.isEmpty) {
      showGeneralError(context, 'Semua input wajib diisi!');
      return false;
    }

    if (password.text.length < 8) {
      showGeneralError(context, 'Panjang password minimal 8 karakter!');
      return false;
    }

    if (password.text != confirmPassword.text) {
      showGeneralError(context, 'Password dan konfirmasi password belum sama!');
      return false;
    }

    return true;
  }

  Future<void> daftarClick(BuildContext context) async {
    setState(() => loading = true);
    if (!validate(context)) {
      setState(() => loading = false);
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

    try {
      var header = {'Content-type': 'application/json'};
      var response = await dio.post(
        url,
        data: data.toMap(),
        options: Options(headers: header),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (context.mounted) {
          Navigator.of(context).pushReplacementNamed('/');
        }
      }
    } on DioException catch (error) {
      if (error.response?.data['message'] != null &&
          error.response?.data['message'].runtimeType == List<dynamic>) {
        showGeneralError(context, error.response?.data['message'][0]);
      } else {
        showGeneralError(context, 'Terjadi kesalahan saat mendaftar');
      }
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                './assets/images/logo-remove.png',
                width: size.width * .4,
                height: size.height * .2,
              ),
              const Text(
                "Register",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              ),
              const SizedBox(height: 25),
              Container(
                width: size.width * 0.9,
                margin: EdgeInsets.all(size.width * 0.001),
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
                  ]),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                height: MediaQuery.of(context).size.height * .059,
                child: ElevatedButton(
                  onPressed: () {
                    daftarClick(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          18.0), // Adjust the value as needed
                    ),
                  ),
                  child: loading
                      ? const SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          "Register",
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Sudah Punya Akun?",
                    style: TextStyle(fontSize: 12),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
