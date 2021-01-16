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
              final item = _items.elementAt(index);
              return ListTile(
                title: Text(item.name),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(item.imageUrl),
                ),
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
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
