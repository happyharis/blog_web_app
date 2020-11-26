import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BlogPost {
  final String body;
  final String title;
  final String id;
  final DateTime publishedDate;

  String get date => DateFormat('d MMMM y').format(publishedDate);

  BlogPost({this.title, this.publishedDate, this.body, this.id});

  factory BlogPost.fromDocument(DocumentSnapshot doc) {
    final map = doc?.data();
    if (map == null) return null;
    return BlogPost(
      title: map['title'],
      body: map['body'],
      publishedDate: map['published_date'].toDate(),
      id: doc.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'published_date': Timestamp.fromDate(publishedDate),
    };
  }
}
