import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:it_product_client/app/app.dart';
import 'package:it_product_client/posts/posts.dart';

class PostList extends StatelessWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.postList.isNotEmpty) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: state.postList.length,
              itemBuilder: (context, index) {
                return PostItem(postEntity: state.postList[index]);
              });
        }
        if (state.asyncSnapshot?.connectionState == ConnectionState.waiting) {
          return const AppLoader();
        }
        return const Center(child: Text('no posts'));
      },
    );
  }
}
