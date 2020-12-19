import 'package:blog_web_app/blog_scaffold.dart';
import 'package:blog_web_app/checkout_page.dart';
import 'package:flutter/material.dart';

class StorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlogScaffold(
      appBar: AppBar(
        title: Text(
          'Store',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          FlatButton(
            child: Text(
              '🛒',
              style: TextStyle(fontSize: 30),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return CheckoutPage();
                  },
                ),
              );
            },
          )
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        children: [
          for (var item in _storeItems)
            Center(
              child: Column(
                children: [
                  Image.network(item.imageUrl),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(item.name),
                      OutlinedButton(
                        child: Icon(Icons.add),
                        onPressed: () {},
                      )
                    ],
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}

class StoreItem {
  final String name;
  final num price;
  final String imageUrl;

  StoreItem({this.name, this.price, this.imageUrl});
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

// https://ibb.co/Tb3cKtS
// https://ibb.co/BZbDRB7
// https://ibb.co/7p24RQn
// https://ibb.co/KLg3Sp5
