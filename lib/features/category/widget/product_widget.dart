import 'package:flutter/material.dart';
import 'package:peasy/core/components/general_text.dart';
import 'package:peasy/core/constants/constants/general_constants.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/constants/enums/product_status_enum.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:peasy/features/category/model/product_model.dart';
import 'package:peasy/features/product/view/product_view.dart';

/// A widget that represents a product item
class ProductWidget extends StatelessWidget {
  final ProductModel product;

  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToProductDetail(context),
      child: Container(
        width: 180,
        padding: PaddingConstants.allMedium,
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: GeneralConstants.instance.borderRadiusMedium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(product.imgPath),
            const SizedBox(height: 8),
            _buildProductTitle(product.name ?? ''),
            const SizedBox(height: 4),
            _buildProductPrice(product.price),
            const SizedBox(height: 4),
            _buildProductStockStatus(product.stock),
          ],
        ),
      ),
    );
  }

  void _navigateToProductDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailView(product: product),
      ),
    );
  }

  Widget _buildProductImage(String? imagePath) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: GeneralConstants.instance.borderRadiusMedium,
        color: Colors.grey.shade200,
      ),
      child: imagePath != null
          ? ClipRRect(
              borderRadius: GeneralConstants.instance.borderRadiusMedium,
              child: Padding(
                padding: PaddingConstants.allSmall,
                child: Image.network(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            )
          : const Icon(Icons.image_not_supported),
    );
  }

  Widget _buildProductTitle(String title) {
    return Helper(
      text: title,
      isBold: true,
    );
  }

  Widget _buildProductPrice(double? price) {
    return Label(
      text: price != null ? price.toStringAsFixed(2) : 'N/A',
    );
  }

  Widget _buildProductStockStatus(int? stock) {
    final quantity = stock ?? 0;
    final status = getStockStatusFromQuantity(quantity);

    return Label(
      text: status.name,
      color: status.color,
    );
  }
}
