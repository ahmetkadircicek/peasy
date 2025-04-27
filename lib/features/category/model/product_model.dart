import 'package:peasy/core/constants/enums/product_status_enum.dart';

class ProductModel {
  final String id;
  final String name;
  final String section;
  final ProductStatusEnum stockStatus;
  final String imagePath;
  final String price;

  ProductModel({
    required this.id,
    required this.name,
    required this.section,
    required this.stockStatus,
    required this.imagePath,
    required this.price,
  });
}
