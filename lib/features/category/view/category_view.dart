import 'package:flutter/material.dart';
import 'package:peasy/core/components/general_sliver_appbar.dart';
import 'package:peasy/core/components/general_text.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:peasy/core/widgets/background.dart';
import 'package:peasy/features/category/viewmodel/category_view_model.dart';
import 'package:peasy/features/category/widget/product_section_widget.dart';
import 'package:provider/provider.dart';

class CategoryView extends StatelessWidget {
  final String categoryTitle;
  const CategoryView({super.key, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        Background(),
        Consumer<CategoryViewModel>(
          builder: (context, viewModel, child) {
            return CustomScrollView(
              slivers: [
                GeneralSliverAppBar(
                  leading: IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      size: 30,
                      color: context.onPrimary,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  title: Content(text: categoryTitle, color: context.onPrimary),
                  actions: [
                    IconButton(
                      icon: Icon(
                        Icons.info,
                        size: 30,
                        color: context.onPrimary,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                SliverPadding(
                  padding: PaddingConstants.pagePadding,
                  sliver: SliverToBoxAdapter(
                    child: ProductSectionWidget(
                        title: 'Featured Products',
                        products: viewModel.products),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
