import 'package:blog_web_app/common/blog_scaffold.dart';
import 'package:blog_web_app/models/store_item.dart';
import 'package:blog_web_app/pages/store_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _storeItems = Provider.of<List<StoreItem>>(context);
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
