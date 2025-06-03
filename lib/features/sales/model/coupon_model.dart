class CouponModel {
  final int couponId;
  final String couponCode;
  final String description;
  final int discountRate;
  final String discountType;
  final String title;

  CouponModel({
    required this.couponId,
    required this.couponCode,
    required this.description,
    required this.discountRate,
    required this.discountType,
    required this.title,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json, String id) {
    return CouponModel(
      couponId: json['couponId'],
      couponCode: json['couponCode'],
      description: json['description'],
      discountRate: json['discountRate'],
      discountType: json['discountType'],
      title: json['title'],
    );
  }
}
