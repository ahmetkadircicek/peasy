import 'package:flutter/material.dart';
import 'package:peasy/core/components/general_text.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/features/category/model/product_model.dart';
import 'package:peasy/features/category/widget/product_widget.dart';

/// A widget that displays products organized by section
class ProductSectionWidget extends StatelessWidget {
  final String title;
  final List<ProductModel> products;

  const ProductSectionWidget({
    super.key,
    required this.title,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, List<ProductModel>> categorizedProducts = {};
    for (var product in products) {
      String section = product.section;
      String category = section[0];
      if (categorizedProducts.containsKey(category)) {
        categorizedProducts[category]?.add(product);
      } else {
        categorizedProducts[category] = [product];
      }
    }
    return SingleChildScrollView(
      child: Column(
        spacing: 16,
        children: categorizedProducts.entries.map((entry) {
          String sectionTitle = entry.key;
          List<ProductModel> sectionProducts = entry.value;
          return Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(sectionTitle),
              _buildProductList(sectionProducts),
            ],
          );
        }).toList(),
      ),
    );
  }

  Content _buildSectionTitle(String sectionTitle) {
    return Content(
      text: 'SECTION $sectionTitle',
      isBold: true,
    );
  }

  /// Builds the list of products for a section.
  Widget _buildProductList(List<ProductModel> products) {
    return ListView.builder(
      padding: PaddingConstants.zeroPadding,
      shrinkWrap: true,
      clipBehavior: Clip.none,
      itemCount: products.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final product = products[index];
        return Padding(
          padding: PaddingConstants.onlyBottomSmall,
          child: ProductWidget(product: product),
        );
      },
    );
  }
}
