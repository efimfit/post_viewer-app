import 'dart:async';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:it_product_client/auth/auth.dart';
import 'package:it_product_client/posts/posts.dart';

part 'post_cubit.freezed.dart';
part 'post_cubit.g.dart';
part 'post_state.dart';

class PostCubit extends HydratedCubit<PostState> {
  final PostRepository postRepository;
  final AuthCubit authCubit;
  late final StreamSubscription authSubscription;

  PostCubit(
    this.postRepository,
    this.authCubit,
  ) : super(const PostState(asyncSnapshot: AsyncSnapshot.nothing())) {
    authSubscription = authCubit.stream.listen((event) {
      event.mapOrNull(
        authorized: (value) => fetchPosts(),
        notAuthorized: (value) => logout(),
      );
    });
  }

  Future<void> fetchPosts() async {
    emit(state.copyWith(asyncSnapshot: const AsyncSnapshot.waiting()));
    await postRepository.fetchPosts().then((value) {
      final Iterable iterable = value;
      emit(state.copyWith(
          postList: iterable.map((e) => PostEntity.fromJson(e)).toList(),
          asyncSnapshot:
              const AsyncSnapshot.withData(ConnectionState.done, true)));
    }).catchError((error) {
      addError(error);
    });
  }

  Future<void> createPosts(Map args) async {
    await postRepository.createPosts(args).then((value) {
      fetchPosts();
    }).catchError((error) {
      addError(error);
    });
  }

  void logout() {
    emit(state.copyWith(
      asyncSnapshot: const AsyncSnapshot.nothing(),
      postList: [],
    ));
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    emit(state.copyWith(
        asyncSnapshot: AsyncSnapshot.withError(ConnectionState.done, error)));
    super.addError(error, stackTrace);
  }

  @override
  PostState? fromJson(Map<String, dynamic> json) {
    return PostState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(PostState state) {
    return state.toJson();
  }

  @override
  Future<void> close() {
    authSubscription.cancel();
    return super.close();
  }
}
