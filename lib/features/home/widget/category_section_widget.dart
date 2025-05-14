import 'package:flutter/material.dart';
import 'package:peasy/core/components/general_tag.dart';
import 'package:peasy/core/components/general_text.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:peasy/features/category/view/category_view.dart';
import 'package:peasy/features/home/model/category_model.dart';
import 'package:peasy/features/home/model/subcategory_model.dart';
import 'package:peasy/features/home/widget/category_widget.dart';

/// A widget that represents a section with categories
class CategorySectionWidget extends StatefulWidget {
  final CategoryModel categoryModel;
  final List<SubcategoryModel> subcategories;
  const CategorySectionWidget({
    super.key,
    required this.categoryModel,
    required this.subcategories,
  });

  @override
  State<CategorySectionWidget> createState() => _CategorySectionWidgetState();
}

class _CategorySectionWidgetState extends State<CategorySectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        _buildCategoryTitle(context, widget.categoryModel),
        _buildSubcategoryList(widget.subcategories),
      ],
    );
  }

  /// Builds a section title widget.
  Widget _buildCategoryTitle(
      BuildContext context, CategoryModel categoryModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Content(
          text: categoryModel.name,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CategoryView(categoryModel: categoryModel),
              ),
            );
          },
          child: GeneralTag(
            label: 'View All',
            color: context.primary,
          ),
        )
      ],
    );
  }

  /// Builds the list of categories for a section.
  Widget _buildSubcategoryList(List<SubcategoryModel> subcategories) {
    return SizedBox(
      height: 240,
      child: ListView.builder(
        clipBehavior: Clip.none,
        itemCount: subcategories.length,
        scrollDirection: Axis.horizontal,
        physics: ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final subcategory = subcategories[index];
          return Padding(
            padding: PaddingConstants.onlyRightSmall,
            child: CategoryWidget(subcategoryModel: subcategory),
          );
        },
      ),
    );
  }
}
