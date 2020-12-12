import 'package:flutter/material.dart';

import 'like_notifier.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({
    Key key,
    @required this.likeNotifier,
  }) : super(key: key);

  final LikeNotifier likeNotifier;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        primary:
            likeNotifier.isLiked ? Colors.blueAccent.shade700 : Colors.black,
      ),
      label: Text('Like'),
      onPressed: likeNotifier.handleTappedLike,
      icon: Icon(
        likeNotifier.isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
      ),
    );
  }
}
