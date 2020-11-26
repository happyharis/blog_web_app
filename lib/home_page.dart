import 'package:blog_web_app/blog_entry_page.dart';
import 'package:blog_web_app/blog_page.dart';
import 'package:blog_web_app/blog_post.dart';
import 'package:blog_web_app/blog_scaffold.dart';
import 'package:blog_web_app/constrained_centre.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'user.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<BlogPost>>(context);
    final user = Provider.of<User>(context);
    return BlogScaffold(
        children: [
          ConstrainedCentre(
            child: CircleAvatar(
              backgroundImage: NetworkImage(user.profilePicture),
              radius: 72,
            ),
          ),
          SizedBox(height: 18),
          ConstrainedCentre(
            child: SelectableText(
              user.name,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          SizedBox(height: 40),
          SelectableText(
            'Hello, I’m a human. I’m a Flutter developer and an avid human. Occasionally, I nap.',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(height: 40),
          SelectableText(
            'Blog',
            style: Theme.of(context).textTheme.headline2,
          ),
          for (var post in posts) BlogListTile(post: post),
        ],
        floatingActionButton: FloatingActionButton.extended(
          label: Text('New Blog'),
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return BlogEntryPage();
              },
            ));
          },
        ));
  }
}

class BlogListTile extends StatelessWidget {
  final BlogPost post;

  const BlogListTile({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        InkWell(
          child: Text(
            post.title,
            style: TextStyle(color: Colors.blueAccent.shade700),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return BlogPage(blogPost: post);
                },
              ),
            );
          },
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SelectableText(
              post.date,
              style: Theme.of(context).textTheme.caption,
            ),
            PopupMenuButton<Action>(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text('Edit'),
                    value: Action.edit,
                  ),
                  PopupMenuItem(
                    child: Text('Delete'),
                    value: Action.delete,
                  ),
                ];
              },
              onSelected: (value) {
                switch (value) {
                  case Action.edit:
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return BlogEntryPage(post: post);
                      },
                    ));
                    break;
                  case Action.delete:
                    break;
                  default:
                }
              },
            )
          ],
        ),
      ],
    );
  }
}

enum Action { edit, delete }
