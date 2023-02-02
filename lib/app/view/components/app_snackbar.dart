import 'package:flutter/material.dart';

import 'package:it_product_client/app/app.dart';

abstract class AppSnackbar {
  AppSnackbar(BuildContext context, ErrorEntity errorEntity);

  static void showSnackbarWithMessage(BuildContext context, String message) {
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: SingleChildScrollView(
          child: Text(message, maxLines: 5),
        ),
      ),
    );
  }

  static void showSnackbarWithError(BuildContext context, ErrorEntity error) {
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: SingleChildScrollView(
          child: Text(
            'Error: ${error.errorMessage}, Message: ${error.message}',
            maxLines: 5,
          ),
        ),
      ),
    );
  }

  static void clearSnackbar(BuildContext context) {
    ScaffoldMessenger.maybeOf(context)?.clearSnackBars();
  }
}
