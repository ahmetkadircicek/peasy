import 'package:flutter/material.dart';

enum ProductStatusEnum {
  inStock,
  lowStock,
  outOfStock;

  String get name {
    switch (this) {
      case ProductStatusEnum.inStock:
        return 'In Stock';
      case ProductStatusEnum.lowStock:
        return 'Almost Gone';
      case ProductStatusEnum.outOfStock:
        return 'Out of Stock';
    }
  }

  Color get color {
    switch (this) {
      case ProductStatusEnum.inStock:
        return Colors.green.shade800;
      case ProductStatusEnum.lowStock:
        return Colors.orange.shade800;
      case ProductStatusEnum.outOfStock:
        return Colors.red.shade800;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case ProductStatusEnum.inStock:
        return Colors.green.shade100;
      case ProductStatusEnum.lowStock:
        return Colors.orange.shade100;
      case ProductStatusEnum.outOfStock:
        return Colors.red.shade100;
    }
  }
}

ProductStatusEnum getStockStatusFromQuantity(int quantity) {
  if (quantity > 5) return ProductStatusEnum.inStock;
  if (quantity > 0) return ProductStatusEnum.lowStock;
  return ProductStatusEnum.outOfStock;
}
