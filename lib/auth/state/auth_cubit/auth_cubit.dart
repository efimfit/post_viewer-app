import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:it_product_client/app/app.dart';
import 'package:it_product_client/auth/auth.dart';

part 'auth_cubit.freezed.dart';
part 'auth_cubit.g.dart';
part 'auth_state.dart';

@Singleton(order: 1)
class AuthCubit extends HydratedCubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(
    this.authRepository,
  ) : super(AuthState.notAuthorized());

  Future<void> signIn(
      {required String username, required String password}) async {
    emit(AuthState.waiting());
    try {
      final UserEntity userEntity =
          await authRepository.signIn(username: username, password: password);
      emit(AuthState.authorized(userEntity));
    } catch (e, stackTrace) {
      addError(e, stackTrace);
    }
  }

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    emit(AuthState.waiting());
    try {
      final UserEntity userEntity = await authRepository.signUp(
          username: username, password: password, email: email);
      emit(AuthState.authorized(userEntity));
    } catch (e, stackTrace) {
      addError(e, stackTrace);
    }
  }

  void logOut() => emit(AuthState.notAuthorized());

  Future<String?> refreshToken() async {
    final refreshToken =
        state.whenOrNull(authorized: (userEntity) => userEntity.refreshToken);
    try {
      return await authRepository
          .refreshToken(refreshToken: refreshToken)
          .then((value) {
        final UserEntity userEntity = value;
        emit(AuthState.authorized(userEntity));
        return userEntity.accessToken;
      });
    } catch (e, stackTrace) {
      addError(e, stackTrace);
    }
    return null;
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    final state = AuthState.fromJson(json);
    return state.whenOrNull(
      authorized: (userEntity) => AuthState.authorized(userEntity),
    );
  }

  Future<void> getProfile() async {
    try {
      _updateUserState(const AsyncSnapshot.waiting());
      await Future.delayed(const Duration(seconds: 1));
      final UserEntity newUserEntity = await authRepository.getProfile();
      emit(state.maybeWhen(
        orElse: () => state,
        authorized: (userEntity) => AuthState.authorized(userEntity.copyWith(
            username: newUserEntity.username, email: newUserEntity.email)),
      ));
      _updateUserState(
          const AsyncSnapshot.withData(ConnectionState.done, 'success'));
    } catch (e) {
      _updateUserState(AsyncSnapshot.withError(ConnectionState.done, e));
    }
  }

  void _updateUserState(AsyncSnapshot asyncSnapshot) {
    emit(state.maybeWhen(
      orElse: () => state,
      authorized: (userEntity) =>
          AuthState.authorized(userEntity.copyWith(userState: asyncSnapshot)),
    ));
  }

  Future<void> updateUser({String? username, String? email}) async {
    try {
      _updateUserState(const AsyncSnapshot.waiting());
      await Future.delayed(const Duration(seconds: 1));

      final bool isEmptyUsername = username?.trim().isEmpty == true;
      final bool isEmptyEmail = email?.trim().isEmpty == true;

      final UserEntity newUserEntity = await authRepository.updateUser(
          username: isEmptyUsername ? null : username,
          email: isEmptyEmail ? null : email);
      emit(state.maybeWhen(
        orElse: () => state,
        authorized: (userEntity) => AuthState.authorized(userEntity.copyWith(
            username: newUserEntity.username, email: newUserEntity.email)),
      ));
      _updateUserState(
          const AsyncSnapshot.withData(ConnectionState.done, 'success'));
    } catch (e) {
      _updateUserState(AsyncSnapshot.withError(ConnectionState.done, e));
    }
  }

  Future<void> updatePassword(
      {required String oldPassword, required String newPassword}) async {
    try {
      _updateUserState(const AsyncSnapshot.waiting());
      await Future.delayed(const Duration(seconds: 1));
      final bool isEmptyPassword = newPassword.trim().isEmpty == true;
      if (isEmptyPassword) {
        throw ErrorEntity(message: 'Empty password');
      }
      final message = await authRepository.updatePassword(
          oldPassword: oldPassword, newPassword: newPassword);

      _updateUserState(AsyncSnapshot.withData(ConnectionState.done, message));
    } catch (e) {
      _updateUserState(AsyncSnapshot.withError(ConnectionState.done, e));
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state
            .whenOrNull(
              authorized: (userEntity) => AuthState.authorized(userEntity),
            )
            ?.toJson() ??
        AuthState.notAuthorized().toJson();
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    emit(AuthState.error(error));
    super.addError(error, stackTrace);
  }
}
