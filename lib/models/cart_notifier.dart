import 'package:blog_web_app/models/store_item.dart';
import 'package:flutter/material.dart';

class CartNotifier extends ChangeNotifier {
  List<StoreItem> _items = [];
  List<StoreItem> get items => _items;

  void remove(StoreItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void add(StoreItem item) {
    _items.add(item);
    notifyListeners();
  }

  num get totalPrice {
    return _items.fold(0, (previousValue, storeItem) {
      return previousValue + storeItem.price;
    });
  }
}
