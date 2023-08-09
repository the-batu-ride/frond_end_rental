import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frond_end_rental/bloc/auth/auth_bloc.dart';
import 'package:frond_end_rental/constant/colors.dart';
import 'package:frond_end_rental/utils/auth_util.dart';
import 'package:frond_end_rental/widget/inputs.dart';
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> loginClick(BuildContext context) async {
    context.read<AuthBloc>()
      ..add(Authenticating())
      ..add(Signin(username: email.text, password: password.text));
  }

  Widget childTextButton(state) {
    if (state is AuthLoading) {
      return const SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2,
        ),
      );
    }

    return const Text(
      'MASUK',
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: whiteColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
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
              'Login',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(height: 10),
            Container(
              margin: EdgeInsets.all(size.width * .09),
              child: Column(
                children: [
                  BaseInput(hint: 'Email', label: 'Email', controller: email),
                  const SizedBox(
                    height: 20,
                  ),
                  BaseInput(
                    hint: 'Password',
                    label: 'Password',
                    controller: password,
                    secure: true,
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: size.width * 9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () => context.goNamed('daftar'),
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: const Text(
                            'Register Now',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: greenPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: size.width * 1,
                    height: size.height * .059,
                    child: ElevatedButton(
                      onPressed: () => loginClick(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: greenPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      child: BlocListener<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is SignedIn) {
                            context.goNamed('home');
                            return;
                          }

                          if (state is SigninFailed) {
                            showGeneralError(context, state.message!);
                            return;
                          }
                        },
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return childTextButton(state);
                          },
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
