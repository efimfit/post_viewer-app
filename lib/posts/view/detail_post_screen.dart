import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:it_product_client/app/app.dart';
import 'package:it_product_client/posts/posts.dart';

class DetailPostScreen extends StatelessWidget {
  final String id;

  const DetailPostScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DetailPostCubit(locator.get<PostRepository>(), id)..fetchPost(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    context.read<DetailPostCubit>().deletePost().then((value) {
                      context.read<PostCubit>().fetchPosts();
                      Navigator.of(context).pop();
                    });
                  },
                  icon: const Icon(Icons.delete))
            ],
          ),
          body: BlocConsumer<DetailPostCubit, DetailPostState>(
            builder: (context, state) {
              if (state.asyncSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return const AppLoader();
              }
              if (state.postEntity != null) {
                return ListView(
                  children: [
                    Text('Name: ${state.postEntity?.name}'),
                    Text('Content: ${state.postEntity?.content}'),
                  ],
                );
              }
              return const Center(child: Text('Error'));
            },
            listener: (context, state) {
              if (state.asyncSnapshot.hasData) {
                AppSnackbar.showSnackbarWithMessage(
                    context, state.asyncSnapshot.data.toString());
              }
              if (state.asyncSnapshot.hasError) {
                AppSnackbar.showSnackbarWithError(context,
                    ErrorEntity.fromException(state.asyncSnapshot.error));
                Navigator.of(context).pop();
              }
            },
          ),
        );
      }),
    );
  }
}
