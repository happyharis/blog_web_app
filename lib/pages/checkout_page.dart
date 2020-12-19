import 'package:blog_web_app/common/blog_scaffold.dart';
import 'package:blog_web_app/pages/store_page.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlogScaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _storeItems.length,
            itemBuilder: (context, index) {
              final item = _storeItems.elementAt(index);
              return ListTile(
                minVerticalPadding: 20,
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(item.imageUrl),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  onPressed: () {},
                ),
                title: Text(item.name),
              );
            },
          ),
        ),
        SizedBox(
          height: 200,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '\$100 ',
                  style: Theme.of(context).textTheme.headline1,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('BUY'),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
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
