import 'package:injectable/injectable.dart';

import 'package:it_product_client/auth/auth.dart';

@Injectable(as: AuthRepository)
@test
class MockAuthRepository implements AuthRepository {
  @override
  Future getProfile() {
    throw UnimplementedError();
  }

  @override
  Future refreshToken({String? refreshToken}) {
    throw UnimplementedError();
  }

  @override
  Future signIn({required String password, required String username}) {
    return Future.delayed(const Duration(seconds: 2), () {
      return UserEntity(
        email: 'test email',
        username: username,
        id: '-1',
      );
    });
  }

  @override
  Future signUp(
      {required String password,
      required String username,
      required String email}) {
    return Future.delayed(const Duration(seconds: 2), () {
      return UserEntity(
        email: email,
        username: username,
        id: '-1',
      );
    });
  }

  @override
  Future updatePassword(
      {required String oldPassword, required String newPassword}) {
    throw UnimplementedError();
  }

  @override
  Future updateUser({
    String? username,
    String? email,
  }) {
    throw UnimplementedError();
  }
}
