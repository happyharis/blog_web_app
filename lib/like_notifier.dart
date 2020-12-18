import 'package:blog_web_app/blog_post.dart';
import 'package:blog_web_app/login_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LikeNotifier extends ChangeNotifier {
  LikeNotifier(this.context);
  final BuildContext context;

  bool _isLiked = false;
  bool isUserLoggedIn;
  bool get isLiked => _isLiked;

  void update(bool _isUserLoggedIn) {
    isUserLoggedIn = _isUserLoggedIn;
    // When log out, there should be no ui that indicates any liked post
    if (!_isUserLoggedIn) {
      _isLiked = false;
    }
  }

  void toggleLike() {
    // If isUserLoggedIn is null, we assume that no one has logged in. Safer.
    if (isUserLoggedIn ?? false) {
      final blog = Provider.of<BlogPost>(context, listen: false);
      _isLiked = !_isLiked;
      notifyListeners();
      // Due to the addition of the likes number property, need to swap nulls
      // with zero.
      final likesNumber = blog.likesNumber;
      final updatedLikeNumber = _isLiked ? likesNumber + 1 : likesNumber - 1;
      BlogPost.updateLikesNumber(blog.id, updatedLikeNumber);
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
