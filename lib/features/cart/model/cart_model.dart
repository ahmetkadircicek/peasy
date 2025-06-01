import 'package:peasy/features/category/model/product_model.dart';

class CartModel {
  final String? productId;
  final String? name;
  final String? description;
  final int? categoryId;
  final double? price;
  final String? imgPath;
  int quantity;
  String? categoryName;

  CartModel({
    this.productId,
    this.name,
    this.description,
    this.categoryId,
    this.price,
    this.imgPath,
    this.quantity = 1,
    this.categoryName,
  });

  double get totalPrice => (price ?? 0) * quantity;

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      productId: json['productId'],
      name: json['name'],
      description: json['description'],
      categoryId: json['categoryId'],
      price: (json['price'] ?? 0).toDouble(),
      imgPath: json['imgPath'],
      quantity: json['quantity'] ?? 1,
      categoryName: json['categoryName'], // Kategori adını ekledik
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'description': description,
      'categoryId': categoryId,
      'price': price,
      'imgPath': imgPath,
      'quantity': quantity,
      'categoryName': categoryName, // Kategori adını ekledik
    };
  }

  CartModel copyWith({
    String? productId,
    String? name,
    String? description,
    int? categoryId,
    double? price,
    String? imgPath,
    int? quantity,
    String? categoryName, // Kategori adını ekledik
  }) {
    return CartModel(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      price: price ?? this.price,
      imgPath: imgPath ?? this.imgPath,
      quantity: quantity ?? this.quantity,
      categoryName: categoryName ?? this.categoryName, // Kategori adını ekledik
    );
  }

  /// ProductModel'den CartModel oluşturmak için
  factory CartModel.fromProductModel(ProductModel product, {int quantity = 1}) {
    return CartModel(
      productId: product.productId,
      name: product.name,
      description: product.description,
      categoryId: product.categoryId,
      price: product.price,
      imgPath: product.imgPath,
      quantity: quantity,
      categoryName: null, // Kategori adını başlangıçta null olarak ayarla
    );
  }
}
