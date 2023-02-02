import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:it_product_client/app/di/init_di.config.dart';

final locator = GetIt.instance;

@InjectableInit()
void initDi(String env) {
  locator.init(environment: env);
}
