import 'package:blog_web_app/blog_entry_page.dart';
import 'package:blog_web_app/blog_page.dart';
import 'package:blog_web_app/blog_post.dart';
import 'package:blog_web_app/like_notifier.dart';
import 'package:blog_web_app/blog_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'like_button.dart';

class BlogListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isAuthorLoggedIn = Provider.of<BlogUser>(context).isAuthorLoggedIn;
    final post = Provider.of<BlogPost>(context);
    // This means that we can get the blog user object instance from
    // change notifier proxy provider.
    return ChangeNotifierProxyProvider<BlogUser, LikeNotifier>(
      create: (context) => LikeNotifier(context),
      update: (context, blogUser, likeNotifier) {
        return likeNotifier..update(blogUser.isLoggedIn);
      },
      builder: (context, child) {
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
                          value: likeNotifier, child: BlogPage(blogPost: post));
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
                if (isAuthorLoggedIn) Spacer(),
                LikeButton(likeNotifier: likeNotifier),
                if (isAuthorLoggedIn) BlogPopUpMenuButton(post: post)
              ],
            ),
            Divider(thickness: 2),
          ],
        );
      },
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
            showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  contentPadding: const EdgeInsets.all(18),
                  children: [
                    Text("Are you sure you want to delete "),
                    Text(
                      post.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.redAccent),
                          onPressed: () {
                            return FirebaseFirestore.instance
                                .collection('blogs')
                                .doc(post.id)
                                .delete()
                                .then((_) {
                              Navigator.of(context).pop();
                            });
                          },
                          child: Text('Delete'),
                        ),
                        SizedBox(width: 20),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Cancel'),
                        )
                      ],
                    ),
                  ],
                );
              },
            );
            break;
          default:
        }
      },
    );
  }
}

enum Action { edit, delete }
