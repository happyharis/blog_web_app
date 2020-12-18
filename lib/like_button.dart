import 'package:blog_web_app/like_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'blog_post.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({
    Key key,
    @required this.likeNotifier,
  }) : super(key: key);

  final LikeNotifier likeNotifier;

  @override
  Widget build(BuildContext context) {
    final likesNumber = Provider.of<BlogPost>(context).likesNumber;
    return TextButton.icon(
      style: TextButton.styleFrom(
        primary:
            likeNotifier.isLiked ? Colors.blueAccent.shade700 : Colors.black,
      ),
      icon: Icon(
        likeNotifier.isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
      ),
      label: Text(likesNumber.toString()),
      onPressed: likeNotifier.toggleLike,
    );
  }
}
