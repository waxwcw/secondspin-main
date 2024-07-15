class Product {
  final String id;
  final String title;
  final String description;
  final String image;
  final double price;
  final String profile_id;
  final String category;
  // final Image image;

  Product({
    required this.id,
    required this.title,
    required this.description,
    // required this.image,
    required this.price,
    // required this.colors,
    required this.category,
    required this.profile_id,
    required this.image,
  });

  // factory Product.fromJson(Map<String, dynamic> json) {
  //   return Product(
  //     id: json['id'],
  //     price: json['price'],
  //     profile_id: json['profile_id'],
  //     image: json['image_url'],
  //     description: json['description'],
  //     title: json['title'],
  //     category: json['category'],
  //   );
  // }
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      price: map['price'],
      profile_id: map['profile_id'],
      image: map['image_url'],
      description: map['description'],
      title: map['title'],
      category: map['category'],
    );
  }
}

List<Product> products = [];
