import 'package:flutter/material.dart';

import 'package:it_product_client/app/app.dart';

class AppDialog extends StatefulWidget {
  final String firstValue;
  final String secondValue;
  final Function(String first, String second) onPressed;

  const AppDialog({
    Key? key,
    required this.firstValue,
    required this.secondValue,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<AppDialog> createState() => _AppDialogState();
}

class _AppDialogState extends State<AppDialog> {
  final firstValueController = TextEditingController();
  final secondValueController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    firstValueController.dispose();
    secondValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                AppTextField(
                    controller: firstValueController,
                    labelText: widget.firstValue),
                const SizedBox(height: 16),
                AppTextField(
                    controller: secondValueController,
                    labelText: widget.secondValue),
                const SizedBox(height: 16),
                AppTextButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() == true) {
                        Navigator.pop(context);
                        widget.onPressed(firstValueController.text,
                            secondValueController.text);
                      }
                    },
                    text: 'Apply'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
