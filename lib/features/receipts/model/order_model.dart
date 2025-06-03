import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final int orderId;
  final DateTime orderDate;
  final double subtotalAmount;
  final double totalAmount;
  final double taxAmount;
  final List<OrderItem> orderItems;

  OrderModel({
    required this.orderId,
    required this.orderDate,
    required this.totalAmount,
    required this.orderItems,
    required this.subtotalAmount,
    required this.taxAmount,
  });

  factory OrderModel.fromMap(Map<String, dynamic> data) {
    return OrderModel(
      orderId: data['orderId'] ?? 0,
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      subtotalAmount: (data['subtotalAmount'] ?? 0).toDouble(),
      taxAmount: (data['taxAmount'] ?? 0).toDouble(),
      totalAmount: (data['totalAmount'] ?? 0).toDouble(),
      orderItems: [], // boş başlatılacak, sonra ViewModel içinde eşlenecek
    );
  }

  OrderModel copyWith({List<OrderItem>? orderItems}) {
    return OrderModel(
      orderId: orderId,
      orderDate: orderDate,
      subtotalAmount: subtotalAmount,
      taxAmount: taxAmount,
      totalAmount: totalAmount,
      orderItems: orderItems ?? this.orderItems,
    );
  }
}

class OrderItem {
  final String productId;
  final int quantity;
  final double price;
  final String name; // Product name
  final String imageUrl;

  OrderItem({
    required this.productId,
    required this.quantity,
    required this.price,
    required this.name,
    required this.imageUrl,
  });
  factory OrderItem.fromRawMap(
      Map<String, dynamic> rawData, Map<String, dynamic> productData) {
    return OrderItem(
      productId: rawData['productId'] ?? '',
      quantity: rawData['quantity'] ?? 0,
      price: (rawData['amount'] ?? 0).toDouble(),
      name: productData['name'] ?? '',
      imageUrl: productData['imgPath'] ?? '',
    );
  }

  Map<String, dynamic> toRawMap() {
    return {
      'productId': productId,
      'quantity': quantity,
      'amount': price,
    };
  }
}
