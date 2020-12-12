import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'blog_entry_page.dart';
import 'blog_page.dart';
import 'blog_post.dart';
import 'like_button.dart';
import 'like_notifier.dart';

class BlogListTile extends StatelessWidget {
  final BlogPost post;

  const BlogListTile({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LikeNotifier(),
      builder: (context, child) {
        final isUserLoggedIn = Provider.of<bool>(context);
        final likeNotifier = Provider.of<LikeNotifier>(context);
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
                      return ChangeNotifierProvider.value(
                        value: likeNotifier,
                        child: BlogPage(blogPost: post),
                      );
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
                if (!isUserLoggedIn) LikeButton(likeNotifier: likeNotifier),
                if (isUserLoggedIn) BlogPopupMenuButton(post: post),
              ],
            ),
            Divider(thickness: 1),
          ],
        );
      },
    );
  }
}

class BlogPopupMenuButton extends StatelessWidget {
  const BlogPopupMenuButton({
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
