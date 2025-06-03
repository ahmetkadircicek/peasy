class PaymentModel {
  final String orderId;
  final double subtotal;
  final double tax;
  final double discount;
  final double total;
  final List<OrderItem> items;
  final PaymentMethod? selectedPaymentMethod;

  PaymentModel({
    required this.orderId,
    required this.subtotal,
    required this.tax,
    required this.discount,
    required this.total,
    required this.items,
    this.selectedPaymentMethod,
  });

  PaymentModel copyWith({
    String? orderId,
    double? subtotal,
    double? tax,
    double? discount,
    double? total,
    List<OrderItem>? items,
    PaymentMethod? selectedPaymentMethod,
  }) {
    return PaymentModel(
      orderId: orderId ?? this.orderId,
      subtotal: subtotal ?? this.subtotal,
      tax: tax ?? this.tax,
      discount: discount ?? this.discount,
      total: total ?? this.total,
      items: items ?? this.items,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
    );
  }
}

class OrderItem {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String? imageUrl;

  OrderItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    this.imageUrl,
  });
}

enum PaymentMethod {
  applePay,
  googlePay,
  creditCard,
}

extension PaymentMethodExtension on PaymentMethod {
  String get displayName {
    switch (this) {
      case PaymentMethod.applePay:
        return 'Apple Pay';
      case PaymentMethod.googlePay:
        return 'Google Pay';
      case PaymentMethod.creditCard:
        return 'Kredi Kartı';
    }
  }

  String get iconPath {
    switch (this) {
      case PaymentMethod.applePay:
        return 'assets/icons/apple_pay.png';
      case PaymentMethod.googlePay:
        return 'assets/icons/google_pay.png';
      case PaymentMethod.creditCard:
        return 'assets/icons/credit_card.png';
    }
  }
}
