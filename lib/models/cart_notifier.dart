import 'package:blog_web_app/models/store_item.dart';
import 'package:flutter/material.dart';

class CartNotifier extends ChangeNotifier {
  List<StoreItem> _catalog;
  List<StoreItem> get catalog => _catalog;

  List<StoreItem> _items = [];
  List<StoreItem> get items => _items;

  set catalog(List<StoreItem> newCatalog) {
    assert(newCatalog != null);
    _catalog = newCatalog;
    notifyListeners();
  }

  int get totalPrice {
    return _items.fold(0, (total, current) => total + current.price);
  }

  void add(StoreItem item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(StoreItem item) {
    _items.remove(item);
    notifyListeners();
  }
}
