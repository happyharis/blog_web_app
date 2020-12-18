import 'package:blog_web_app/blog_post.dart';
import 'package:blog_web_app/login_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'blog_user.dart';

class LikeNotifier extends ChangeNotifier {
  LikeNotifier(this.context);
  final BuildContext context;

  bool _isLiked;
  bool isUserLoggedIn;
  bool get isLiked => _isLiked ?? false;

  void updateLoginStatus(bool _isUserLoggedIn) {
    isUserLoggedIn = _isUserLoggedIn;
    // When log out, there should be no ui that indicates any liked post
    if (!_isUserLoggedIn) {
      _isLiked = false;
    }
  }

  void initLikeStatus(bool isLiked) {
    _isLiked = isLiked ?? false;
    if (!isUserLoggedIn) {
      _isLiked = false;
    }
    notifyListeners();
  }

  void toggleLike() {
    // If isUserLoggedIn is null, we assume that no one has logged in. Safer.
    if (isUserLoggedIn ?? false) {
      final blog = Provider.of<BlogPost>(context, listen: false);
      var likedPosts = Provider.of<List<String>>(context, listen: false);
      final user = Provider.of<User>(context, listen: false);
      _isLiked = !_isLiked;
      notifyListeners();
      // Due to the addition of the likes number property, need to swap nulls
      // with zero.
      final addedPost = [...likedPosts, blog.id];
      final likesNumber = blog.likesNumber;
      final updatedLikeNumber = _isLiked ? likesNumber + 1 : likesNumber - 1;
      final updatedLikedPosts =
          _isLiked ? addedPost : (likedPosts..remove(blog.id));
      BlogPost.updateLikesNumber(blog.id, updatedLikeNumber);
      BlogUser.updateLikedBlogs(user.uid, updatedLikedPosts);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return LoginDialog();
        },
      );
    }
  }
}