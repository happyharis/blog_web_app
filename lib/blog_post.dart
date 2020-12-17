import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BlogPost {
  final String title;
  final DateTime publishedDate;
  final String body;
  final String id;
  final bool isLiked;

  String get date => DateFormat('d MMMM y').format(publishedDate);

  BlogPost({this.title, this.publishedDate, this.body, this.id, this.isLiked});

  factory BlogPost.fromDocument(DocumentSnapshot doc) {
    final map = doc?.data();
    if (map == null) return null;

    return BlogPost(
      title: map['title'],
      body: map['body'],
      publishedDate: map['published_date'].toDate(),
      id: doc.id,
      isLiked: map['is_liked'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'published_date': Timestamp.fromDate(publishedDate),
      'is_liked': isLiked,
    };
  }

  BlogPost copyWith({
    String title,
    DateTime publishedDate,
    String body,
    String id,
    bool isLiked,
  }) {
    return BlogPost(
      title: title ?? this.title,
      publishedDate: publishedDate ?? this.publishedDate,
      body: body ?? this.body,
      id: id ?? this.id,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
