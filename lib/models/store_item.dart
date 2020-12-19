class StoreItem {
  final String name;
  final num price;
  final String imageUrl;

  StoreItem({this.name, this.price, this.imageUrl});

  @override
  String toString() {
    return 'StoreItem(name: $name, price: $price, imageUrl: $imageUrl)';
  }
}
