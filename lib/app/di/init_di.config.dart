// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:it_product_client/app/app.dart' as _i3;
import 'package:it_product_client/app/configs/main_app_config.dart' as _i4;
import 'package:it_product_client/app/data_providers/dio_app_api.dart' as _i7;
import 'package:it_product_client/auth/auth.dart' as _i5;
import 'package:it_product_client/auth/repositories/mock_auth_repository.dart'
    as _i6;
import 'package:it_product_client/auth/repositories/network_auth_repository.dart'
    as _i8;
import 'package:it_product_client/auth/state/auth_cubit/auth_cubit.dart'
    as _i11;
import 'package:it_product_client/posts/posts.dart' as _i9;
import 'package:it_product_client/posts/repositories/network_post_repository.dart'
    as _i10;

const String _prod = 'prod';
const String _dev = 'dev';
const String _test = 'test';

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.AppConfig>(
      _i4.ProdAppConfig(),
      registerFor: {_prod},
    );
    gh.singleton<_i3.AppConfig>(
      _i4.DevAppConfig(),
      registerFor: {_dev},
    );
    gh.singleton<_i3.AppConfig>(
      _i4.TestAppConfig(),
      registerFor: {_test},
    );
    gh.factory<_i5.AuthRepository>(
      () => _i6.MockAuthRepository(),
      registerFor: {_test},
    );
    gh.singleton<_i3.AppApi>(_i7.DioAppApi(gh<_i3.AppConfig>()));
    gh.factory<_i5.AuthRepository>(
      () => _i8.NetworkAuthRepository(api: gh<_i3.AppApi>()),
      registerFor: {_prod},
    );
    gh.factory<_i9.PostRepository>(
        () => _i10.NetworkPostRepository(gh<_i3.AppApi>()));
    gh.singleton<_i11.AuthCubit>(_i11.AuthCubit(gh<_i5.AuthRepository>()));
    return this;
  }
}
