abstract class PostRepository {
  Future fetchPosts();

  Future fetchPost(String id);

  Future createPosts(Map args);

  Future deletePost(String id);
}
