import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:it_product_client/app/app.dart';
import 'package:it_product_client/auth/auth.dart';
import 'package:it_product_client/posts/posts.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key? key,
    required this.userEntity,
  }) : super(key: key);

  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main screen'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AppDialog(
                  firstValue: 'Name',
                  secondValue: 'Content',
                  onPressed: (first, second) =>
                      context.read<PostCubit>().createPosts({
                    'name': first,
                    'content': second,
                  }),
                ),
              );
            },
            icon: const Icon(Icons.email),
          ),
          IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const UserScreen())),
            icon: const Icon(Icons.account_box),
          ),
        ],
      ),
      body: const PostList(),
    );
  }
}
