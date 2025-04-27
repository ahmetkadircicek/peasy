import 'package:flutter/material.dart';

enum ProductStatusEnum {
  inStock,
  outOfStock;

  String get name =>
      this == ProductStatusEnum.inStock ? 'In Stock' : 'Out of Stock';

  Color get color =>
      this == ProductStatusEnum.inStock ? Colors.green : Colors.red;
}
