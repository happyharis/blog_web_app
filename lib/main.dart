import 'package:blog_web_app/blog_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';
import 'user.dart';

var theme = ThemeData(
  primarySwatch: Colors.blue,
  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w800,
      color: Colors.black,
    ),
    headline2: TextStyle(
      fontSize: 27,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    bodyText2: TextStyle(fontSize: 22, height: 1.4),
    caption: TextStyle(fontSize: 18, height: 1.4),
  ),
  appBarTheme: AppBarTheme(
    color: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
  ),
);
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>(
            create: (context) => FirebaseAuth.instance.authStateChanges()),
        StreamProvider<List<BlogPost>>(
          initialData: [],
          create: (context) => blogPosts(),
        ),
        ProxyProvider<User, BlogUser>(
          create: (context) => BlogUser(
            name: 'Flutter Dev',
            profilePicture: 'https://i.ibb.co/ZKkSW4H/profile-image.png',
            isLoggedIn: false,
          ),
          update: (context, user, blogUser) => BlogUser(
            name: blogUser.name,
            profilePicture: blogUser.profilePicture,
            isLoggedIn: user != null,
          ),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Dev Blog',
        theme: theme,
        home: HomePage(),
      ),
    );
  }
}

Stream<List<BlogPost>> blogPosts() {
  return FirebaseFirestore.instance
      .collection('blogs')
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) => BlogPost.fromDocument(doc)).toList()
      ..sort((first, last) {
        final firstDate = first.publishedDate;
        final lastDate = last.publishedDate;
        return -firstDate.compareTo(lastDate);
      });
  });
}
