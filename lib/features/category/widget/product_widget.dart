import 'package:flutter/material.dart';
import 'package:peasy/core/components/general_text.dart';
import 'package:peasy/core/constants/constants/general_constants.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:peasy/features/category/model/product_model.dart';

/// A widget that represents a product item
class ProductWidget extends StatelessWidget {
  final ProductModel product;

  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: PaddingConstants.allSmall,
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: GeneralConstants.instance.borderRadiusMedium,
      ),
      child: Row(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildProductImage(product.imagePath),
          _buildProductInfo(product, context),
          _buildProductSectionNumber(product.section),
          _buildProductStockStatus(product.stockStatus),
        ],
      ),
    );
  }

  Widget _buildProductInfo(ProductModel product, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildProductTitle(product.name),
        _buildProductId(context, product.id),
      ],
    );
  }

  /// Builds the product image widget.
  Widget _buildProductImage(String imagePath) {
    return AspectRatio(
      aspectRatio: 1,
      child: Image.asset(imagePath),
    );
  }

  /// Builds the product section number widget.
  Widget _buildProductSectionNumber(String sectionNumber) {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: Helper(
          text: sectionNumber,
        ),
      ),
    );
  }

  /// Builds the product title widget.
  Widget _buildProductTitle(String title) {
    return Helper(
      text: title,
    );
  }

  /// Builds the product ID widget.
  Widget _buildProductId(BuildContext context, String id) {
    return Label(
      text: id,
      color: context.secondary,
    );
  }

  /// Builds the product stock status widget.
  Widget _buildProductStockStatus(String stockStatus) {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: Helper(
          text: stockStatus,
          color: stockStatus == 'In Stock' ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
