import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final int orderId;
  final DateTime orderDate;
  final double totalAmount;
  final List<OrderItem> orderItems;

  OrderModel({
    required this.orderId,
    required this.orderDate,
    required this.totalAmount,
    required this.orderItems,
  });

  factory OrderModel.fromMap(Map<String, dynamic> data) {
    return OrderModel(
      orderId: data['orderId'] ?? 0,
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      totalAmount: (data['totalAmount'] ?? 0).toDouble(),
      orderItems: (data['orderItems'] as List<dynamic>).map((item) {
        return OrderItem.fromMap(item);
      }).toList(),
    );
  }
}

class OrderItem {
  final String name;
  final int quantity;
  final double price;

  OrderItem({
    required this.name,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromMap(Map<String, dynamic> data) {
    return OrderItem(
      name: data['name'] ?? '',
      quantity: data['quantity'] ?? 0,
      price: (data['price'] ?? 0).toDouble(),
    );
  }
}
