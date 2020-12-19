import 'package:blog_web_app/pages/blog_entry_page.dart';
import 'package:blog_web_app/models/blog_post.dart';
import 'package:blog_web_app/common/blog_scaffold.dart';
import 'package:blog_web_app/common/constrained_centre.dart';
import 'package:blog_web_app/common/login_dialog.dart';
import 'package:blog_web_app/pages/store_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/blog_list_tile.dart';
import '../models/blog_user.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isUserLoggedIn = Provider.of<BlogUser>(context).isLoggedIn;
    final posts = Provider.of<List<BlogPost>>(context);
    final user = Provider.of<BlogUser>(context);
    return BlogScaffold(
        appBar: AppBar(
          actions: [
            FlatButton(
              child: Text(
                isUserLoggedIn ? '🚪' : '🔐',
                style: TextStyle(fontSize: 30),
              ),
              onPressed: () {
                if (isUserLoggedIn) {
                  FirebaseAuth.instance.signOut();
                } else {
                  // Login dialog
                  showDialog(
                    context: context,
                    builder: (context) {
                      return LoginDialog();
                    },
                  );
                }
              },
            ),
            FlatButton(
              child: Text(
                // '🛒',
                '🛍️',
                style: TextStyle(fontSize: 30),
              ),
              onPressed: () => Navigator.of(context).pushNamed('/store'),
            ),
          ],
        ),
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
        floatingActionButton: isUserLoggedIn
            ? FloatingActionButton.extended(
                label: Text('New Blog'),
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return BlogEntryPage();
                    },
                  ));
                },
              )
            : SizedBox());
  }
}
