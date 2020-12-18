import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BlogPost {
  final String title;
  final DateTime publishedDate;
  final String body;
  final String id;
  // Added new likesNumber property
  final int likesNumber;

  String get date => DateFormat('d MMMM y').format(publishedDate);

  BlogPost({
    this.title,
    this.publishedDate,
    this.body,
    this.id,
    this.likesNumber,
  });

  factory BlogPost.fromDocument(DocumentSnapshot doc) {
    final map = doc?.data();
    if (map == null) return null;

    return BlogPost(
      title: map['title'],
      body: map['body'],
      publishedDate: map['published_date'].toDate(),
      id: doc.id,
      likesNumber: map['likes_number'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'published_date': Timestamp.fromDate(publishedDate),
    };
  }

  // Create a simple firestore function to update the likes
  static void updateLikesNumber(String blogId, int updatedLikeNumber) {
    FirebaseFirestore.instance
        .collection('blogs')
        .doc(blogId)
        .update({'likes_number': updatedLikeNumber});
  }
}
