import 'package:blog_web_app/blog_post.dart';
import 'package:blog_web_app/blog_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'blog_user.dart';
import 'constrained_centre.dart';
import 'like_button.dart';

class BlogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<BlogUser>(context);
    final blogPost = Provider.of<BlogPost>(context);
    return BlogScaffold(
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
            LikeButton(),
          ],
        ),
        SizedBox(height: 20),
        SelectableText(blogPost.body),
      ],
    );
  }
}
