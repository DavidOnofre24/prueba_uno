class Product {
  int? selected;
  // bool? isAGift;
  int? id;
  String? name;
  String? image;
  int? price;
  int? quantity;
  bool? promotion;
  List<int>? match;

  Product(
    this.selected,
    // this.isAGift,
    this.id,
    this.name,
    this.image,
    this.price,
    this.quantity,
    this.promotion,
    this.match,
  );

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      map['selected'] != null ? map['selected'] as int : null,
      // map['isAGift'] != null ? map['is_a_gift'] as bool : null,
      map['id'] != null ? map['id'] as int : null,
      map['name'] != null ? map['name'] as String : null,
      map['image'] != null ? map['image'] as String : null,
      map['price'] != null ? map['price'] as int : null,
      map['quantityInCart'] != null ? map['quantityInCart'] as int : null,
      map['promotion'] != null ? map['promotion'] as bool : null,
      map['match'] != null ? (map['match'] as List).cast<int>() : null,
    );
  }
}
