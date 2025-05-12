class ProductModel {
  int? categoryId;
  String? description;
  String? name;
  double? price;
  double? rating;
  double? salePrice;
  int? stock;
  int? subcategoryId;

  ProductModel(
      {this.categoryId,
      this.description,
      this.name,
      this.price,
      this.rating,
      this.salePrice,
      this.stock,
      this.subcategoryId});

  ProductModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    description = json['description'];
    name = json['name'];
    price = json['price'];
    rating = json['rating'];
    salePrice = json['salePrice'];
    stock = json['stock'];
    subcategoryId = json['subcategoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['description'] = description;
    data['name'] = name;
    data['price'] = price;
    data['rating'] = rating;
    data['salePrice'] = salePrice;
    data['stock'] = stock;
    data['subcategoryId'] = subcategoryId;
    return data;
  }
}
