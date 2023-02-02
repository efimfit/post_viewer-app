import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:it_product_client/app/app.dart';
import 'package:it_product_client/posts/posts.dart';

@Injectable(as: PostRepository)
class NetworkPostRepository implements PostRepository {
  final AppApi api;

  NetworkPostRepository(this.api);

  @override
  Future<Iterable> fetchPosts() async {
    try {
      final Response response = await api.fetchPosts();
      return response.data['data'];
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<PostEntity> fetchPost(String id) async {
    try {
      final Response response = await api.fetchPost(id);
      return PostEntity.fromJson(response.data['data']);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> createPosts(Map args) async {
    try {
      final Response response = await api.createPosts(args);
      return response.data['message'];
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future deletePost(String id) async {
    try {
      await api.deletePost(id);
    } catch (_) {
      rethrow;
    }
  }
}
