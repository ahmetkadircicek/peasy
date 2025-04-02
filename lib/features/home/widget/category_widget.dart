import 'package:flutter/material.dart';
import 'package:peasy/core/components/general_text.dart';
import 'package:peasy/core/constants/constants/general_constants.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:peasy/features/home/model/category_model.dart';

/// A widget that represents a category item
class CategoryWidget extends StatelessWidget {
  final CategoryModel category;

  const CategoryWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: PaddingConstants.allSmall,
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: GeneralConstants.instance.borderRadiusMedium,
      ),
      child: Column(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryImage(category.imagePath),
          _buildCategoryTitle(category.title),
          _buildCategoryDescription(context, category.description),
        ],
      ),
    );
  }

  /// Builds the category image widget.
  Widget _buildCategoryImage(String imagePath) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: GeneralConstants.instance.borderRadiusMedium,
        color: Colors.amber.withValues(alpha: 0.4),
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
    return Label(
      text: description,
      color: context.secondary,
      overflow: true,
      maxLines: 2,
    );
  }
}
