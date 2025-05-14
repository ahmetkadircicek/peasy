import 'package:flutter/material.dart';
import 'package:peasy/core/components/general_text.dart';
import 'package:peasy/core/constants/constants/general_constants.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:peasy/features/category/view/category_view.dart';
import 'package:peasy/features/home/model/subcategory_model.dart';
import 'package:peasy/features/home/service/category_service.dart';

/// A widget that represents a category item
class CategoryWidget extends StatelessWidget {
  final SubcategoryModel subcategoryModel;

  const CategoryWidget({super.key, required this.subcategoryModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToSubcategoryProducts(context),
      child: Container(
        width: 180,
        padding: PaddingConstants.allMedium,
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: GeneralConstants.instance.borderRadiusMedium,
        ),
        child: Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryImage(subcategoryModel.imagePath),
            _buildCategoryTitle(subcategoryModel.title),
            _buildCategoryDescription(context, subcategoryModel.description),
          ],
        ),
      ),
    );
  }

  void _navigateToSubcategoryProducts(BuildContext context) async {
    final String categoryId = subcategoryModel.categoryId;

    // Bu alt kategori ID'si
    final String subcategoryId = subcategoryModel.id;

    // Ana kategoriyi getir
    final categoryModel = await CategoryService().getCategoryById(categoryId);

    if (categoryModel != null) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return CategoryView(
              categoryModel: categoryModel,
              subcategoryId: subcategoryId, // Alt kategori ID'sini geçiyoruz
            );
          },
        ),
      );
    }
  }

  /// Builds the category image widget.
  Widget _buildCategoryImage(String imagePath) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: GeneralConstants.instance.borderRadiusMedium,
        color: Colors.amber.withOpacity(0.4),
      ),
      child: Image.asset(imagePath),
    );
  }

  /// Builds the category title widget.
  Widget _buildCategoryTitle(String title) {
    return Helper(
      text: title,
    );
  }

  /// Builds the category description widget.
  Widget _buildCategoryDescription(BuildContext context, String description) {
    return Expanded(
      child: Label(
        text: description,
        color: context.secondary,
        overflow: true,
        maxLines: 2,
      ),
    );
  }
}
