import 'package:blog_web_app/common/blog_scaffold.dart';
import 'package:blog_web_app/models/cart_notifier.dart';
import 'package:blog_web_app/models/store_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _storeItems = context.watch<CartNotifier>().catalog;
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
            onPressed: () => Navigator.of(context).pushNamed('/checkout'),
          )
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        children: [for (var item in _storeItems) ItemCard(item: item)],
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key key,
    @required this.item,
  }) : super(key: key);

  final StoreItem item;

  @override
  Widget build(BuildContext context) {
    final isInCart = context.select<CartNotifier, bool>(
      (cart) => cart.items.contains(item),
    );
    return Center(
      child: Column(
        children: [
          Image.network(item.imageUrl),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(item.name),
              OutlinedButton(
                child: Icon(isInCart ? Icons.check : Icons.add),
                onPressed: isInCart
                    ? null
                    : () {
                        final cart = context.read<CartNotifier>();
                        cart.add(item);
                        print(cart.items);
                      },
              )
            ],
          ),
        ],
      ),
    );
  }
}
