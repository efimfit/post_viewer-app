import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:it_product_client/app/app.dart';
import 'package:it_product_client/auth/auth.dart';
import 'package:it_product_client/posts/posts.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your account'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthCubit>().logOut();
              context.read<PostCubit>().logout();
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
        state.whenOrNull(
          authorized: (userEntity) {
            if (userEntity.userState?.hasData == true) {
              AppSnackbar.showSnackbarWithMessage(
                  context, userEntity.userState?.data);
            }
            if (userEntity.userState?.hasError == true) {
              AppSnackbar.showSnackbarWithError(context,
                  ErrorEntity.fromException(userEntity.userState?.error));
            }
          },
        );
      }, builder: (context, state) {
        final userEntity =
            state.whenOrNull(authorized: (userEntity) => userEntity);
        if (userEntity?.userState?.connectionState == ConnectionState.waiting) {
          return const AppLoader();
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(
                      userEntity?.username.split('').first.toUpperCase() ??
                          '-'),
                ),
                const SizedBox(width: 16),
                Column(
                  children: [
                    Text(userEntity?.username ?? ''),
                    Text(userEntity?.email ?? ''),
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AppDialog(
                          firstValue: 'Current password',
                          secondValue: 'New password',
                          onPressed: (first, second) {
                            context.read<AuthCubit>().updatePassword(
                                oldPassword: first, newPassword: second);
                          },
                        ),
                      );
                    },
                    child: const Text('Update password')),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AppDialog(
                        firstValue: 'Username',
                        secondValue: 'Email',
                        onPressed: (first, second) {
                          context
                              .read<AuthCubit>()
                              .updateUser(username: first, email: second);
                        },
                      ),
                    );
                  },
                  child: const Text('Update data'),
                ),
              ],
            ),
          ]),
        );
      }),
    );
  }
}
