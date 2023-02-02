import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:it_product_client/app/app.dart';
import 'package:it_product_client/auth/auth.dart';

class AuthBuilder extends StatelessWidget {
  const AuthBuilder({
    Key? key,
    required this.isNotAuthorized,
    required this.waiting,
    required this.isAuthorized,
  }) : super(key: key);

  final WidgetBuilder isNotAuthorized;
  final WidgetBuilder waiting;
  final ValueWidgetBuilder isAuthorized;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      builder: (context, state) {
        return state.when(
          notAuthorized: () => isNotAuthorized(context),
          authorized: (userEntity) => isAuthorized(context, userEntity, this),
          waiting: () => waiting(context),
          error: (error) => isNotAuthorized(context),
        );
      },
      listenWhen: (previous, current) =>
          previous.mapOrNull(
            error: (value) => value,
          ) !=
          current.mapOrNull(
            error: (value) => value,
          ),
      listener: (context, state) {
        state.whenOrNull(
          error: (error) => AppSnackbar.showSnackbarWithError(
              context, ErrorEntity.fromException(error)),
        );
      },
    );
  }
}
