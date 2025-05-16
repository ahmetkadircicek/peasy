class CartModel {
  final String id;
  final String imagePath;
  final String name;
  final double price;
  int quantity;
  final String? description;
  final String? category;

  CartModel({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.price,
    required this.quantity,
    this.description,
    this.category,
  });

  double get totalPrice => price * quantity;

  // Miktarı artır
  void incrementQuantity() {
    quantity++;
  }

  // Miktarı azalt
  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }

  // JSON'dan model oluştur
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] ?? '',
      imagePath: json['imagePath'] ?? 'assets/images/product.png',
      name: json['name'] ?? 'Ürün',
      price: (json['price'] ?? 0.0).toDouble(),
      quantity: json['quantity'] ?? 1,
      description: json['description'],
      category: json['category'],
    );
  }

  // Model'den JSON oluştur
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imagePath': imagePath,
      'name': name,
      'price': price,
      'quantity': quantity,
      'description': description,
      'category': category,
    };
  }

  // Kopyalama metodu
  CartModel copyWith({
    String? id,
    String? imagePath,
    String? name,
    double? price,
    int? quantity,
    String? description,
    String? category,
  }) {
    return CartModel(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
      category: category ?? this.category,
    );
  }
}
