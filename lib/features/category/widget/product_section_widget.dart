import 'package:flutter/material.dart';
import 'package:peasy/core/components/general_text.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:peasy/features/category/model/product_model.dart';
import 'package:peasy/features/category/viewmodel/category_view_model.dart';
import 'package:peasy/features/category/widget/product_widget.dart';
import 'package:peasy/features/home/model/category_model.dart';
import 'package:provider/provider.dart';

/// A widget that displays products organized by section
class ProductSectionWidget extends StatelessWidget {
  final CategoryModel categoryModel;

  const ProductSectionWidget({
    super.key,
    required this.categoryModel,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const SizedBox(
            height: 300,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (viewModel.categorizedProducts.isEmpty) {
          return SizedBox(
            height: 300,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 64,
                    color: context.secondary.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Content(
                    text: 'No products found',
                    color: context.secondary,
                  ),
                ],
              ),
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            spacing: 24,
            children: viewModel.categorizedProducts.entries.map((entry) {
              String sectionKey = entry.key;
              List<ProductModel> sectionProducts = entry.value;
              return Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(viewModel, sectionKey),
                  _buildProductList(context, sectionProducts),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(CategoryViewModel viewModel, String sectionKey) {
    // ViewModel üzerinden alt kategori adını al
    final sectionName = viewModel.getSubcategoryName(sectionKey);

    return Content(
      text: sectionName,
      isBold: true,
    );
  }

  /// Builds a responsive grid-like layout with 2 items per row using Wrap.
  Widget _buildProductList(BuildContext context, List<ProductModel> products) {
    final double itemWidth = (context.width - 3 * 16) / 2;
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: products.map((product) {
        return SizedBox(
          width: itemWidth,
          child: ProductWidget(product: product),
        );
      }).toList(),
    );
  }
}
