import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frond_end_rental/constant/colors.dart';
import 'package:frond_end_rental/models/auth.dart';
import 'package:frond_end_rental/models/register_model.dart';
import 'package:frond_end_rental/repositories/auth_repository.dart';
import 'package:frond_end_rental/utils/auth_util.dart';
import 'package:frond_end_rental/widget/appbar_custom.dart';
import 'package:frond_end_rental/widget/bottom_menu.dart';
import 'package:frond_end_rental/widget/inputs.dart';
import 'package:frond_end_rental/widget/loader.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailText = TextEditingController();
  final firstName = TextEditingController();
  final lastname = TextEditingController();
  final alamat = TextEditingController();
  final password = TextEditingController(text: 'defaultt');
  final confirmPassword = TextEditingController(text: 'defaultt');
  AuthEntity? entity;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final response = await AuthRepository.checkAuth();
      emailText.text = response.email;
      firstName.text = response.name.split(' ').first;
      lastname.text = response.name.split(' ').last;
      alamat.text = response.address;
      setState(() => entity = response);
    } on DioException catch (_) {
      showGeneralError(context, 'Gagal mengambil data');
    }
  }

  Future<void> _saveClick() async {
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
      await AuthRepository.update(model, entity!.id);
    } on DioException catch (_) {
      showGeneralError(context, 'Gagal memperbarui profile!');
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  void dispose() {
    emailText.dispose();
    password.dispose();
    firstName.dispose();
    lastname.dispose();
    alamat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        'Profile',
        null,
        context,
        path: 'home',
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 25,
            horizontal: 30,
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Text(
                    'Update Profile',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    InputWithValidate(
                      controller: emailText,
                      hint: 'Your e-mail',
                      label: 'E-Mail',
                      validation: const ['', null],
                    ),
                    const SizedBox(height: 25),
                    InputWithValidate(
                      controller: firstName,
                      hint: 'First Name',
                      label: 'First Name',
                      validation: const ['', null],
                    ),
                    const SizedBox(height: 25),
                    InputWithValidate(
                      controller: lastname,
                      hint: 'Last Name',
                      label: 'Last Name',
                      validation: const ['', null],
                    ),
                    const SizedBox(height: 25),
                    InputWithValidate(
                      controller: alamat,
                      hint: 'Address',
                      label: 'Address',
                      validation: const ['', null],
                    ),
                    const SizedBox(height: 25),
                    InputWithValidate(
                      controller: password,
                      hint: 'Password',
                      label: 'Password',
                      secure: true,
                      validation: const ['', null, 8],
                    ),
                    const SizedBox(height: 25),
                    InputWithValidate(
                      controller: confirmPassword,
                      hint: 'Confirm Password',
                      label: 'Confirm Password',
                      secure: true,
                      validation: const ['', null, 8],
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 70,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: ElevatedButton(
                        onPressed: _saveClick,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                        ),
                        child: loading
                            ? const CenterLoader(color: Colors.white)
                            : const Text('Save'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomMenu(),
    );
  }
}
