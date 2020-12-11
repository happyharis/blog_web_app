import 'package:flutter/material.dart';

class LikeNotifier extends ChangeNotifier {
  bool isLiked = false;

  void handleTappedLike() {
    isLiked = !isLiked;
    notifyListeners();
  }
}
