import 'package:flutter/material.dart';

class StoreItem {
  final String name;
  final String imageUrl;
  final num price;

  StoreItem({
    @required this.name,
    @required this.imageUrl,
    @required this.price,
  });
}
