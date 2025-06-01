class ProductModel {
  String? productId; // Firestore document ID olarak eklendi
  int? categoryId;
  String? description;
  String? name;
  double? price;
  double? rating;
  double? salePrice;
  int? stock;
  int? subcategoryId;
  String? imgPath; // Burada ekledik

  ProductModel({
    this.productId,
    this.categoryId,
    this.description,
    this.name,
    this.price,
    this.rating,
    this.salePrice,
    this.stock,
    this.subcategoryId,
    this.imgPath, // constructor parametresi
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['productId'],
      categoryId: json['categoryId'],
      description: json['description'],
      name: json['name'],
      price: (json['price'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      salePrice: (json['salePrice'] ?? 0).toDouble(),
      stock: json['stock'],
      subcategoryId: json['subcategoryId'],
      imgPath: json['imgPath'], // Burayı ekledik
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'description': description,
      'name': name,
      'price': price,
      'rating': rating,
      'salePrice': salePrice,
      'stock': stock,
      'subcategoryId': subcategoryId,
      'imgPath': imgPath, // Burayı ekledik
    };
  }
}
