import 'package:blog_web_app/common/blog_scaffold.dart';
import 'package:blog_web_app/models/store_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _storeItems = Provider.of<List<StoreItem>>(context);
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
