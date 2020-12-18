import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'blog_post.dart';

class LikeNotifier extends ChangeNotifier {
  final BlogPost post;
  LikeNotifier(this.post);

  bool isLiked = false;

  void init() {
    isLiked = post.isLiked;
  }

  void handleTappedLike() {
    isLiked = !isLiked;
    FirebaseFirestore.instance
        .collection('blogs')
        .doc(post.id)
        .update({'is_liked': isLiked});
    notifyListeners();
  }
}
