import 'package:flutter/material.dart';
import 'package:peasy/core/components/general_text.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/constants/enums/product_status_enum.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:peasy/features/category/model/product_model.dart';

// Enum ve helper fonksiyon yukarıda tanımlanmış olmalı

class ProductDetailView extends StatelessWidget {
  final ProductModel product;

  const ProductDetailView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final quantity = product.stock ?? 0;
    final stockStatus = getStockStatusFromQuantity(quantity);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name ?? 'Product'),
        backgroundColor: context.primary,
        foregroundColor: context.onPrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProductImage(product.imgPath),
            Padding(
              padding: PaddingConstants.pagePadding,
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Content(
                    text: product.name ?? 'Unnamed Product',
                    fontSize: 20,
                    isBold: true,
                  ),
                  Label(
                    text: '\$${product.price?.toStringAsFixed(2) ?? 'N/A'}',
                    fontSize: 18,
                    color: context.primary,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: stockStatus.backgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      stockStatus.name,
                      style: TextStyle(
                        color: stockStatus.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Content(
                    text: 'Description',
                    isBold: true,
                    fontSize: 16,
                  ),
                  Helper(
                    text: product.description ?? 'No description available.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(String? imagePath) {
    return imagePath != null
        ? ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            child: Image.network(
              imagePath,
              width: double.infinity,
              height: 240,
              fit: BoxFit.contain,
            ),
          )
        : Container(
            height: 240,
            color: Colors.grey.shade200,
            child: const Center(
              child: Icon(Icons.image_not_supported, size: 64),
            ),
          );
  }
}
