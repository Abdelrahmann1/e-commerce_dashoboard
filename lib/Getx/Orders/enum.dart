enum OrderStatus { pending, processing, shipped, delivered, cancelled, all }

// models/ItemModel.dart
class Item {
  String variationId;
  String image;

  Item({required this.variationId, required this.image});

  factory Item.fromString(String itemString) {
    var parts = itemString.split(':');
    return Item(
      variationId: parts[0],
      image: parts[1],
    );
  }

  @override
  String toString() {
    return '$variationId:$image';
  }
}
