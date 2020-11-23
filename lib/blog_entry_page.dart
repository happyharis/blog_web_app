import 'package:blog_web_app/blog_post.dart';
import 'package:blog_web_app/blog_scaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BlogEntryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    final titleController = TextEditingController(text: '');
    final bodyController = TextEditingController(text: '');
    return BlogScaffold(
      children: [
        TextField(
          style: _textTheme.headline1,
          controller: titleController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Title',
          ),
        ),
        TextField(
          style: _textTheme.bodyText2,
          controller: bodyController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Write your blog here...',
          ),
        ),
      ],
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Submit'),
        icon: Icon(Icons.book),
        onPressed: () {
          final title = titleController.text;
          final body = bodyController.text;
          final blogPost = BlogPost(
            title: title,
            body: body,
            publishedDate: DateTime.now(),
          ).toMap();
          FirebaseFirestore.instance
              .collection('blogs')
              .add(blogPost)
              .then((_) {
            Navigator.of(context).pop();
          });
        },
      ),
    );
  }
}
