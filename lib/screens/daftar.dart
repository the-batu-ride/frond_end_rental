import 'package:dio/dio.dart' show DioException;
import 'package:flutter/material.dart';
import 'package:frond_end_rental/errors/unauthorize_error.dart';
import 'package:frond_end_rental/models/register_model.dart';
import 'package:frond_end_rental/repositories/auth_repository.dart';
import 'package:frond_end_rental/utils/auth_util.dart'
    show showGeneralError, showSuccessMessage;
import 'package:frond_end_rental/widget/inputs.dart' show InputWithValidate;
import 'package:go_router/go_router.dart';
import '../constant/colors.dart';

class Daftar extends StatefulWidget {
  const Daftar({super.key});

  @override
  State<Daftar> createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
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

  bool validate(BuildContext context) => false;

  Future<void> daftarClick(BuildContext context) async {
    setState(() => loading = true);
    if (_formKey.currentState?.validate() == false) {
      setState(() => loading = false);
      return;
    }

    final model = RegisterModel(
      email: emailText.text,
      firstName: firstName.text,
      lastName: lastname.text,
      adress: alamat.text,
      password: password.text,
    );

    try {
      await AuthRepository.register(model);
      if (context.mounted) {
        showSuccessMessage(context, 'Berhasil mendaftar');
        context.goNamed('login');
      }
    } on DioException catch (_) {
      showGeneralError(context, 'Terjadi kesalahan saat mendaftar');
    } on UnauthorizeError catch (e) {
      showGeneralError(context, e.message);
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
                'Register',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              ),
              const SizedBox(height: 25),
              Container(
                width: size.width * 0.9,
                margin: EdgeInsets.all(size.width * 0.001),
                child: Container(
                  margin: EdgeInsets.all(size.width * 0.05),
                  child: Form(
                    key: _formKey,
                    child: Column(children: [
                      InputWithValidate(
                        hint: 'Your e-mail',
                        label: 'E-Mail',
                        controller: emailText,
                        validation: const ['', null],
                      ),
                      const SizedBox(height: 25),
                      InputWithValidate(
                        hint: 'First Name',
                        label: 'First Name',
                        controller: firstName,
                        validation: const ['', null],
                      ),
                      const SizedBox(height: 25),
                      InputWithValidate(
                        hint: 'Last Name',
                        label: 'Last Name',
                        controller: lastname,
                        validation: const ['', null],
                      ),
                      const SizedBox(height: 25),
                      InputWithValidate(
                        hint: 'Address',
                        label: 'Address',
                        controller: alamat,
                        validation: const ['', null],
                      ),
                      const SizedBox(height: 25),
                      InputWithValidate(
                        hint: 'Password',
                        label: 'Password',
                        controller: password,
                        secure: true,
                        validation: const ['', null, 8],
                      ),
                      const SizedBox(height: 25),
                      InputWithValidate(
                        hint: 'Confirm Password',
                        label: 'Confirm Password',
                        controller: confirmPassword,
                        secure: true,
                        validation: const ['', null, 8],
                      ),
                    ]),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                height: MediaQuery.of(context).size.height * .059,
                child: ElevatedButton(
                  onPressed: () => daftarClick(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  child: loading
                      ? const Padding(
                          padding: EdgeInsets.all(7),
                          child: SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : const Text(
                          'Register',
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
                    'Sudah Punya Akun?',
                    style: TextStyle(fontSize: 12),
                  ),
                  TextButton(
                    onPressed: () => context.goNamed('login'),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text(
                      'Login',
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
