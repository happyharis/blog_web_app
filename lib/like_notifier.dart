import 'package:blog_web_app/login_dialog.dart';
import 'package:blog_web_app/user.dart';
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
  }

  void toggleLike() {
    if (isUserLoggedIn ?? false) {
      _isLiked = !_isLiked;
      notifyListeners();
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
