import 'package:blog_web_app/blog_post.dart';
import 'package:blog_web_app/constrained_centre.dart';
import 'package:blog_web_app/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'blog_scaffold.dart';

class BlogPage extends StatelessWidget {
  final BlogPost post;

  const BlogPage({Key key, @required this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return BlogScaffold(
      children: [
        ConstrainedCentre(
          child: Column(
            children: [
              CircleAvatar(
                radius: 54,
                backgroundImage: NetworkImage(user.profilePicture),
              ),
              SizedBox(height: 18),
              Text(
                user.name,
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
        SizedBox(height: 40),
        SelectableText(
          post.title,
          style: Theme.of(context).textTheme.headline1.copyWith(
                fontSize: 36,
              ),
        ),
        SizedBox(height: 20),
        SelectableText(
          post.date,
          style: Theme.of(context).textTheme.caption,
        ),
        SizedBox(height: 20),
        SelectableText(post.body),
      ],
    );
  }
}
