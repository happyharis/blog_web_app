import 'package:blog_web_app/blog_entry_page.dart';
import 'package:blog_web_app/blog_page.dart';
import 'package:blog_web_app/blog_post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogListTile extends StatelessWidget {
  final BlogPost post;

  const BlogListTile({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final isUserLoggedIn = Provider.of<bool>(context);
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
            TextButton.icon(
              icon: Icon(Icons.thumb_up_outlined),
              label: Text('Like'),
              onPressed: () {},
            ),
            if (isUserLoggedIn) BlogPopUpMenuButton(post: post)
          ],
        ),
        Divider(thickness: 2),
      ],
    );
  }
}

class BlogPopUpMenuButton extends StatelessWidget {
  const BlogPopUpMenuButton({
    Key key,
    @required this.post,
  }) : super(key: key);

  final BlogPost post;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Action>(
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
    );
  }
}

enum Action { edit, delete }
