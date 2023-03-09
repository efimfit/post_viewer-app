import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:it_product_client/posts/posts.dart';

part 'detail_post_cubit.freezed.dart';
part 'detail_post_state.dart';

class DetailPostCubit extends Cubit<DetailPostState> {
  final PostRepository postRepository;
  final String id;

  DetailPostCubit(
    this.postRepository,
    this.id,
  ) : super(const DetailPostState());

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    emit(state.copyWith(
        asyncSnapshot: AsyncSnapshot.withError(ConnectionState.done, error)));
    super.addError(error, stackTrace);
  }

  Future<void> fetchPost() async {
    emit(state.copyWith(asyncSnapshot: const AsyncSnapshot.waiting()));
    await postRepository.fetchPost(id).then((value) {
      emit(state.copyWith(
          postEntity: value,
          asyncSnapshot: const AsyncSnapshot.withData(
              ConnectionState.done, 'Receiving post is successfull')));
    }).catchError((error) {
      addError(error);
    });
  }

  Future<void> deletePost() async {
    emit(state.copyWith(asyncSnapshot: const AsyncSnapshot.waiting()));
    await postRepository.deletePost(id).then((_) {
      emit(state.copyWith(
          asyncSnapshot: const AsyncSnapshot.withData(
              ConnectionState.done, 'Deleting post is successfull')));
    }).catchError((error) {
      addError(error);
    });
  }
}
