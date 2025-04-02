import 'package:flutter/material.dart';
import 'package:peasy/core/components/general_text.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:peasy/features/category/view/category_view.dart';
import 'package:peasy/features/home/model/category_model.dart';
import 'package:peasy/features/home/model/section_model.dart';
import 'package:peasy/features/home/widget/category_widget.dart';

/// A widget that represents a section with categories
class CategorySectionWidget extends StatelessWidget {
  final SectionModel section;

  const CategorySectionWidget({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        _buildSectionTitle(context, section.title),
        _buildCategoryList(section.categories),
      ],
    );
  }

  /// Builds a section title widget.
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Content(
          text: title,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryView(categoryTitle: title),
              ),
            );
          },
          child: Helper(
            text: 'View All',
            color: context.primary,
          ),
        )
      ],
    );
  }

  /// Builds the list of categories for a section.
  Widget _buildCategoryList(List<CategoryModel> categories) {
    return SizedBox(
      height: 240,
      child: ListView.builder(
        clipBehavior: Clip.none,
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        physics: ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final category = categories[index];
          return Padding(
            padding: PaddingConstants.onlyRightSmall,
            child: CategoryWidget(category: category),
          );
        },
      ),
    );
  }
}
