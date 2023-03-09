import 'package:injectable/injectable.dart';

import 'package:it_product_client/app/app.dart';
import 'package:it_product_client/auth/auth.dart';

@Injectable(as: AuthRepository)
@prod
class NetworkAuthRepository implements AuthRepository {
  final AppApi api;

  NetworkAuthRepository({
    required this.api,
  });

  @override
  Future<UserEntity> getProfile() async {
    try {
      final response = await api.getProfile();
      return UserDto.fromJson(response.data['data']).toEntity();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> refreshToken({String? refreshToken}) async {
    try {
      final response = await api.refreshToken(refreshToken: refreshToken);
      return UserDto.fromJson(response.data['data']).toEntity();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> signIn(
      {required String username, required String password}) async {
    try {
      final response = await api.signIn(username: username, password: password);
      return UserDto.fromJson(response.data['data']).toEntity();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> signUp(
      {required String password,
      required String username,
      required String email}) async {
    try {
      final response = await api.signUp(
          password: password, username: username, email: email);
      return UserDto.fromJson(response.data['data']).toEntity();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> updatePassword(
      {required String oldPassword, required String newPassword}) async {
    try {
      final response = await api.updatePassword(
          oldPassword: oldPassword, newPassword: newPassword);
      return response.data['message'];
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> updateUser({String? username, String? email}) async {
    try {
      final response = await api.updateUser(username: username, email: email);
      return UserDto.fromJson(response.data['data']).toEntity();
    } catch (_) {
      rethrow;
    }
  }
}
