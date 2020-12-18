import 'package:cloud_firestore/cloud_firestore.dart';

class BlogUser {
  final String profilePicture;
  final String name;
  final bool isAuthor;
  final bool isLoggedIn;

  bool get isAuthorLoggedIn => isAuthor && isLoggedIn;

  BlogUser({this.isAuthor, this.isLoggedIn, this.profilePicture, this.name});

  static void updateLikedBlogs(String uid, List<String> updatedBlogs) {
    FirebaseFirestore.instance
        .collection('visitors')
        .doc(uid)
        .update({'liked_blog_posts': updatedBlogs});
  }
}
