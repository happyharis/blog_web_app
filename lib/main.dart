import 'package:blog_web_app/common_widgets/blog_post.dart';
import 'package:blog_web_app/models/cart_notifier.dart';
import 'package:blog_web_app/pages/checkout_page.dart';
import 'package:blog_web_app/pages/store_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/store_item.dart';
import 'pages/home_page.dart';
import 'models/user.dart';

var theme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
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
          create: (context) => FirebaseAuth.instance.authStateChanges(),
        ),
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
          update: (context, firebaseUser, blogUser) => BlogUser(
            name: blogUser.name,
            profilePicture: blogUser.profilePicture,
            isLoggedIn: firebaseUser != null,
          ),
        ),
        Provider<List<StoreItem>>(
          create: (context) => _storeItems,
        ),
        ChangeNotifierProvider<CartNotifier>(
          create: (context) => CartNotifier(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Dev Blog',
        theme: theme,
        home: HomePage(),
        routes: {
          '/store': (context) => StorePage(),
          '/checkout': (context) => CheckoutPage(),
        },
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

final _storeItems = [
  StoreItem(
    id: 1,
    name: 'Flutter Shirt',
    price: 12,
    imageUrl: 'https://i.ibb.co/SdCNQB8/1.png',
  ),
  StoreItem(
    id: 2,
    name: 'Flutter Cap',
    price: 3,
    imageUrl: 'https://i.ibb.co/gP8BhLr/2.png',
  ),
  StoreItem(
    id: 3,
    name: 'Flutter Mug',
    price: 4,
    imageUrl: 'https://i.ibb.co/t28Xxzq/3.png',
  ),
  StoreItem(
    id: 4,
    name: 'Flutter Bottle',
    price: 13,
    imageUrl: 'https://i.ibb.co/bBThnXy/4.png',
  ),
];
