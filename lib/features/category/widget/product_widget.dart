import 'package:flutter/material.dart';
import 'package:peasy/core/components/general_tag.dart';
import 'package:peasy/core/components/general_text.dart';
import 'package:peasy/core/constants/constants/general_constants.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/constants/enums/product_status_enum.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:peasy/features/category/model/product_model.dart';

/// A widget that represents a product item
class ProductWidget extends StatelessWidget {
  final ProductModel product;

  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PaddingConstants.allSmall,
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: GeneralConstants.instance.borderRadiusMedium,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildProductInfo(product, context),
          _buildProductSectionChip(
              product.section, product.stockStatus, context),
          _buildProductStockChip(product.stockStatus, context),
          _buildProductPrice(product.price, context),
        ],
      ),
    );
  }

  Widget _buildProductInfo(ProductModel product, BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        _buildProductImage(product.imagePath),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildProductTitle(product.name),
            _buildProductId(context, product.id),
          ],
        ),
      ],
    );
  }

  /// Builds the product image widget.
  Widget _buildProductImage(String imagePath) {
    return Image.asset(imagePath);
  }

  /// Builds the product section chip widget using GeneralTag.
  Widget _buildProductSectionChip(String sectionNumber,
      ProductStatusEnum stockStatus, BuildContext context) {
    return GeneralTag(label: sectionNumber, color: context.primary);
  }

  /// Builds the product stock chip widget using GeneralTag.
  Widget _buildProductStockChip(
      ProductStatusEnum stockStatus, BuildContext context) {
    return GeneralTag(label: stockStatus.name, color: stockStatus.color);
  }

  /// Builds the product price widget.
  Widget _buildProductPrice(String price, BuildContext context) {
    return Helper(
      text: '\$$price',
      color: context.onSurface,
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
}
