import 'package:blog_web_app/common_widgets/blog_post.dart';
import 'package:blog_web_app/common_widgets/blog_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common_widgets/constrained_centre.dart';
import '../common_widgets/like_button.dart';
import '../models/like_notifier.dart';
import '../models/user.dart';

class BlogPage extends StatelessWidget {
  final BlogPost blogPost;

  const BlogPage({Key key, this.blogPost}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<BlogUser>(context);
    final likeNotifier = Provider.of<LikeNotifier>(context);
    return BlogScaffold(
      isScrollable: true,
      children: [
        ConstrainedCentre(
          child: CircleAvatar(
            backgroundImage: NetworkImage(user.profilePicture),
            radius: 54,
          ),
        ),
        SizedBox(height: 18),
        ConstrainedCentre(
          child: SelectableText(
            user.name,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        SizedBox(height: 40),
        SelectableText(
          blogPost.title,
          style: Theme.of(context).textTheme.headline1,
        ),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SelectableText(
              blogPost.date,
              style: Theme.of(context).textTheme.caption,
            ),
            LikeButton(likeNotifier: likeNotifier),
          ],
        ),
        SizedBox(height: 20),
        SelectableText(blogPost.body),
      ],
    );
  }
}
