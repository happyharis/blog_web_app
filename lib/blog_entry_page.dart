import 'package:blog_web_app/blog_post.dart';
import 'package:blog_web_app/blog_scaffold.dart';
import 'package:blog_web_app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BlogEntryPage extends StatelessWidget {
  final BlogPost post;

  const BlogEntryPage({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var _textTheme = Theme.of(context).textTheme;
    final titleController = TextEditingController(text: post?.title ?? '');
    final bodyController = TextEditingController(text: post?.body ?? '');
    final isEdit = post != null;
    return BlogScaffold(
      children: [
        // Title
        TextField(
          controller: titleController,
          maxLines: null,
          style: _textTheme.headline1,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Title',
          ),
        ),
        // Body
        TextField(
          controller: bodyController,
          maxLines: null,
          style: _textTheme.bodyText2,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Write your blog here...',
          ),
        ),
      ],
      floatingActionButton: FloatingActionButton.extended(
        label: Text(isEdit ? 'Update' : 'Submit'),
        icon: Icon(isEdit ? Icons.check : Icons.book),
        onPressed: () {
          final title = titleController.text;
          final body = bodyController.text;
          final blogPost = BlogPost(
            title: title,
            body: body,
            publishedDate: DateTime.now(),
          );
          handleBlogUpdate(
            isEdit: isEdit,
            newPost: blogPost,
            oldPost: post,
          ).then((value) {
            Navigator.of(context).pop();
          });
        },
      ),
    );
  }
}

Future<void> handleBlogUpdate({
  bool isEdit,
  BlogPost newPost,
  BlogPost oldPost,
}) async {
  final newMapPost = newPost.toMap();
  if (isEdit) {
    blogsRef.doc(oldPost.id).update(newMapPost);
    // blogsRef.doc(oldPost.id).set(newPost);
    // await FirebaseFirestore.instance
    //     .collection('blogs')
    //     .doc(oldPost.id)
    //     .update(newMapPost);
  } else {
    // await FirebaseFirestore.instance.collection('blogs').add(newMapPost);
    await blogsRef.add(newPost);
  }
}
