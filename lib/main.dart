import 'package:flutter/material.dart';

import 'package:it_product_client/app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  const env = String.fromEnvironment('env', defaultValue: 'prod');
  final runner = MainAppRunner(env);
  final builder = MainAppBuilder();

  runner.run(builder);
}
