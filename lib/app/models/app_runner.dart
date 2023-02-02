import 'package:it_product_client/app/app.dart';

abstract class AppRunner {
  Future<void> preloadData();
  Future<void> run(AppBuilder appBuilder);
}
