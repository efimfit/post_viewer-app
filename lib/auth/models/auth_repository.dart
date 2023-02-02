abstract class AuthRepository {
  Future<dynamic> signUp({
    required String password,
    required String username,
    required String email,
  });

  Future<dynamic> signIn({
    required String username,
    required String password,
  });

  Future<dynamic> getProfile();

  Future<dynamic> updateUser({
    String? username,
    String? email,
  });

  Future<dynamic> updatePassword({
    required String oldPassword,
    required String newPassword,
  });

  Future<dynamic> refreshToken({String? refreshToken});
}
