import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:it_product_client/app/app.dart';
import 'package:it_product_client/auth/auth.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  final controllerLogin = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerPasswordConfirm = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration screen')),
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
              const SizedBox(height: 16),
              AppTextField(
                controller: controllerEmail,
                labelText: 'Email',
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: controllerPassword,
                labelText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: controllerPasswordConfirm,
                labelText: 'Confirm password',
                obscureText: true,
              ),
              const SizedBox(height: 16),
              AppTextButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() == false) return;
                    if (controllerPassword.text !=
                        controllerPasswordConfirm.text) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Passwords do not match')));
                    } else {
                      _onTapToSignUp(context.read<AuthCubit>());
                      Navigator.of(context).pop();
                    }
                  },
                  text: 'Sign up'),
            ],
          ),
        )),
      ),
    );
  }

  void _onTapToSignUp(AuthCubit authCubit) {
    authCubit.signUp(
      username: controllerLogin.text,
      password: controllerPassword.text,
      email: controllerEmail.text,
    );
  }
}
