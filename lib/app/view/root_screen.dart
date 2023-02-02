import 'package:flutter/material.dart';

import 'package:it_product_client/app/app.dart';
import 'package:it_product_client/auth/auth.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBuilder(
      isNotAuthorized: (context) => LoginScreen(),
      waiting: (context) => const AppLoader(),
      isAuthorized: (context, value, child) => MainScreen(userEntity: value),
    );
  }
}
