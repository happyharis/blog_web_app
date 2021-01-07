import 'package:blog_web_app/models/blog_post.dart';
import 'package:blog_web_app/models/cart_notifier.dart';
import 'package:blog_web_app/pages/store_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/store_item.dart';
import 'pages/checkout_page.dart';
import 'pages/home_page.dart';
import 'models/blog_user.dart';

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
    titleTextStyle: TextStyle(color: Colors.black),
  ),
  scaffoldBackgroundColor: Colors.white,
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
        StreamProvider<List<QueryDocumentSnapshot>>(
          initialData: [],
          create: (context) => storeItemsStream(),
        ),
        ChangeNotifierProxyProvider<List<QueryDocumentSnapshot>, CartNotifier>(
          create: (context) => CartNotifier(),
          update: (context, storeItemsDocs, cart) {
            cart.catalog = storeItemsDocs.map((e) {
              return StoreItem.fromDocument(e);
            }).toList();
            return cart;
          },
        )
      ],
      child: MaterialApp(
        title: 'Flutter Dev Blog',
        debugShowCheckedModeBanner: false,
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

Stream<List<QueryDocumentSnapshot>> storeItemsStream() {
  return FirebaseFirestore.instance
      .collection('store_items')
      .snapshots()
      .map((snapshot) {
    return snapshot.docs;
  });
}

final _storeItems = [
  StoreItem(
    name: 'Flutter Shirt',
    price: 12,
    imageUrl: 'https://i.ibb.co/SdCNQB8/1.png',
  ),
  StoreItem(
    name: 'Flutter Cap',
    price: 3,
    imageUrl: 'https://i.ibb.co/gP8BhLr/2.png',
  ),
  StoreItem(
    name: 'Flutter Mug',
    price: 4,
    imageUrl: 'https://i.ibb.co/t28Xxzq/3.png',
  ),
  StoreItem(
    name: 'Flutter Bottle',
    price: 13,
    imageUrl: 'https://i.ibb.co/bBThnXy/4.png',
  ),
];
