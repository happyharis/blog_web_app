import 'package:blog_web_app/common/blog_scaffold.dart';
import 'package:blog_web_app/models/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartNotifier>();
    final _items = cart.items;
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
            itemCount: _items.length,
            itemBuilder: (context, index) {
              final item = _items.elementAt(index);
              return ListTile(
                minVerticalPadding: 20,
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(item.imageUrl),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    context.read<CartNotifier>().remove(item);
                  },
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
                  '\$${cart.totalPrice} ',
                  style: Theme.of(context).textTheme.headline1,
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Comming soon...')),
                    );
                  },
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
