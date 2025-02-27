import 'package:flutter/material.dart';
import 'package:peasy/core/components/general_appbar.dart';
import 'package:peasy/core/components/general_text.dart';
import 'package:peasy/core/constants/constants/general_constants.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:peasy/features/category/model/product_model.dart';
import 'package:peasy/features/category/viewmodel/category_view_model.dart';
import 'package:provider/provider.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBar(title: 'Fruits and Vegetables'),
      extendBodyBehindAppBar: true,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Image.asset('assets/images/background_vector.png'),
        Consumer<CategoryViewModel>(
          builder: (context, viewModel, child) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: PaddingConstants.pagePadding + PaddingConstants.onlyTopSmall,
                  child: _buildProductSection(context, 'Featured Products', viewModel.products),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  /// Builds a single product section widget.
  Widget _buildProductSection(BuildContext context, String title, List<ProductModel> products) {
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
    return Column(
      spacing: 16,
      children: categorizedProducts.entries.map((entry) {
        String sectionTitle = entry.key;
        List<ProductModel> sectionProducts = entry.value;
        return Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Content(
              text: 'SECTION $sectionTitle ',
              isBold: true,
            ),
            _buildProductList(sectionProducts),
          ],
        );
      }).toList(),
    );
  }

  /// Builds the list of products for a section.
  Widget _buildProductList(List<ProductModel> products) {
    return ListView.builder(
      shrinkWrap: true,
      clipBehavior: Clip.none,
      itemCount: products.length,
      physics: ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final product = products[index];
        return Padding(
          padding: PaddingConstants.onlyBottomSmall,
          child: _buildProductContainer(context, product),
        );
      },
    );
  }

  /// Builds the product container widget.
  Widget _buildProductContainer(BuildContext context, ProductModel product) {
    return Container(
      height: 60,
      padding: PaddingConstants.allSmall,
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: GeneralConstants.instance.borderRadius,
      ),
      child: Row(
        spacing: 16,
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
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductTitle(product.name),
          _buildProductId(context, product.id),
        ],
      ),
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
      child: Center(
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
