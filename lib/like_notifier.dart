import 'package:blog_web_app/blog_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LikeNotifier extends ChangeNotifier {
  final BlogPost post;
  LikeNotifier(this.post);

  bool _isLiked = false;

  void update() {
    _isLiked = post.isLiked;
  }

  bool get isLiked => _isLiked;

  void toggleLike() {
    _isLiked = !_isLiked;
    FirebaseFirestore.instance
        .collection('blogs')
        .doc(post.id)
        .update(post.copyWith(isLiked: _isLiked).toMap());
    notifyListeners();
  }
}
