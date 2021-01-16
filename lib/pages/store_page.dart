import 'package:blog_web_app/common_widgets/blog_scaffold.dart';
import 'package:blog_web_app/models/cart_notifier.dart';
import 'package:blog_web_app/models/store_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension StoreItems on BuildContext {
  List<StoreItem> getStoreItems() {
    return Provider.of<List<StoreItem>>(this);
  }
}

class StorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final _storeItems = Provider.of<List<StoreItem>>(context);
    final _storeItems = context.getStoreItems();
    return BlogScaffold(
      appBar: AppBar(
        title: Text(
          'Store',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => Navigator.of(context).pushNamed('/checkout'),
          )
        ],
      ),
      body: GridView.count(
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        children: [for (var item in _storeItems) ItemCard(item: item)],
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final StoreItem item;

  const ItemCard({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print('item card rebuilt');
    final isInCart = context.select<CartNotifier, bool>((cart) {
      return cart.items.contains(item);
    });
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(item.name),
            Image.network(item.imageUrl),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$' + item.price.toString()),
                ElevatedButton(
                  onPressed: isInCart
                      ? null
                      : () => context.read<CartNotifier>().add(item),
                  child: Text(isInCart ? 'Added' : 'Add to cart'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
