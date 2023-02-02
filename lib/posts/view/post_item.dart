import 'package:flutter/material.dart';

import 'package:it_product_client/posts/posts.dart';

class PostItem extends StatelessWidget {
  final PostEntity postEntity;

  const PostItem({super.key, required this.postEntity});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetailPostScreen(id: postEntity.id.toString()),
      )),
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Text(postEntity.name),
            Text(postEntity.preContent ?? ''),
          ],
        ),
      ),
    );
  }
}
