import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BlogPost {
  final String title;
  final DateTime publishedDate;
  final String body;

  String get date => DateFormat('d MMMM y').format(publishedDate);

  BlogPost({this.title, this.publishedDate, this.body});

  factory BlogPost.fromDocument(DocumentSnapshot doc) {
    if (doc == null || doc?.data() == null) return null;
    final map = doc.data();

    return BlogPost(
      title: map['title'],
      publishedDate: map['published_date'].toDate(),
      body: map['body'],
    );
  }
}
