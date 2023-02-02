import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:it_product_client/app/app.dart';
import 'package:it_product_client/auth/auth.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controllerLogin = TextEditingController();
  final controllerPassword = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('login screen')),
      body: Form(
        key: formKey,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              AppTextField(
                controller: controllerLogin,
                labelText: 'Login',
              ),
              AppTextField(
                controller: controllerPassword,
                labelText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 16),
              AppTextButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() == true) {
                      _onTapToSignIn(context.read<AuthCubit>());
                    }
                  },
                  text: 'Sign in'),
              const SizedBox(height: 16),
              AppTextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RegistrationScreen(),
                    ));
                  },
                  text: 'Sign up'),
            ],
          ),
        )),
      ),
    );
  }

  void _onTapToSignIn(AuthCubit authCubit) {
    authCubit.signIn(
        username: controllerLogin.text, password: controllerPassword.text);
  }
}
