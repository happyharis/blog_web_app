import 'package:blog_web_app/common_widgets/blog_scaffold.dart';
import 'package:blog_web_app/models/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartNotifier>();
    final _items = cart.items;
    return BlogScaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: TextStyle(color: Colors.black),
        ),
      ),
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (context, index) {
              // final item = _items[index];
              final item = _items.elementAt(index);
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    item.imageUrl,
                  ),
                ),
                title: Text(item.name),
                trailing: IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  onPressed: () => context.read<CartNotifier>().remove(item),
                ),
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
                  '\$' + cart.totalPrice.toString(),
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  child: Text('BUY'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Coming soon...'),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
