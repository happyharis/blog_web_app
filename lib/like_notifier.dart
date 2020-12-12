import 'package:flutter/material.dart';

class LikeNotifier extends ChangeNotifier {
  bool _isLiked = false;

  bool get isLiked => _isLiked;

  void toggleLike() {
    _isLiked = !_isLiked;
    notifyListeners();
  }
}
