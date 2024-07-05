// class Product {
//   final int id;
//   final String title;
//   final double price;
//   final String description;
//   final String category;
//   final String image;
//
//   const Product(
//       {required this.category,
//       required this.description,
//       required this.id,
//       required this.image,
//       required this.price,
//       required this.title});
//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//         category: json['category'],
//         description: json['description'],
//         id: json['id'],
//         image: json['image'],
//         price: double.parse(json['category'].toString()),
//         title: json['title']);
//   }
// }
class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      image: json['image'],
    );
  }
}
