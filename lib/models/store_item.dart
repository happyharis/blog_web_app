import 'package:cloud_firestore/cloud_firestore.dart';

class StoreItem {
  final String name;
  final int price;
  final String imageUrl;

  StoreItem({this.name, this.price, this.imageUrl});

  @override
  String toString() {
    return 'StoreItem(name: $name, price: $price, imageUrl: $imageUrl)';
  }

  factory StoreItem.fromDocument(DocumentSnapshot doc) {
    final map = doc?.data();
    if (map == null) return null;

    return StoreItem(
      name: map['name'],
      price: map['price'],
      imageUrl: map['image_url'],
    );
  }
}
