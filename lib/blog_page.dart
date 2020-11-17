import 'package:blog_web_app/blog_post.dart';
import 'package:blog_web_app/blog_scaffold.dart';
import 'package:flutter/material.dart';

import 'constrained_centre.dart';

class BlogPage extends StatelessWidget {
  final BlogPost blogPost;

  const BlogPage({Key key, this.blogPost}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlogScaffold(
      children: [
        ConstrainedCentre(
          child: CircleAvatar(
            backgroundImage:
                NetworkImage('https://i.ibb.co/ZKkSW4H/profile-image.png'),
            radius: 54,
          ),
        ),
        SizedBox(height: 18),
        ConstrainedCentre(
          child: SelectableText(
            'Flutter Dev',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        SizedBox(height: 40),
        SelectableText(
          blogPost.title,
          style: Theme.of(context).textTheme.headline1,
        ),
        SizedBox(height: 40),
        SelectableText(
          blogPost.date,
          style: Theme.of(context).textTheme.caption,
        ),
        SizedBox(height: 20),
        SelectableText(blogPost.body),
      ],
    );
  }
}
