import 'package:flutter/material.dart';
import 'package:peasy/core/components/general_background.dart';
import 'package:peasy/core/components/general_sliver_appbar.dart';
import 'package:peasy/core/components/general_text.dart';
import 'package:peasy/core/constants/constants/general_constants.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:peasy/features/category/viewmodel/category_view_model.dart';
import 'package:peasy/features/category/widget/product_section_widget.dart';
import 'package:peasy/features/home/model/category_model.dart';
import 'package:provider/provider.dart';

class CategoryView extends StatefulWidget {
  final CategoryModel categoryModel;
  final String? subcategoryId;

  const CategoryView({
    super.key,
    required this.categoryModel,
    this.subcategoryId,
  });

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  void initState() {
    super.initState();

    // Post frame callback kullanarak build işleminden sonra veri yükleme işlemini başlat
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final viewModel = Provider.of<CategoryViewModel>(context, listen: false);

    // ViewModel üzerinden kategori verilerini yükle
    await viewModel.loadCategoryData(
      widget.categoryModel.id,
      subcategoryId: widget.subcategoryId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        GeneralBackground(),
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
                  title: _buildTitle(context, viewModel),
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
                // Alt kategori filtreleme butonları
                if (viewModel.subcategories.isNotEmpty)
                  SliverToBoxAdapter(
                    child: _buildSubcategoryFilters(context, viewModel),
                  ),
                SliverPadding(
                  padding: PaddingConstants.pagePadding,
                  sliver: SliverToBoxAdapter(
                    child: ProductSectionWidget(
                        categoryModel: widget.categoryModel),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  // Alt kategori filtre butonlarını oluşturur
  Widget _buildSubcategoryFilters(
      BuildContext context, CategoryViewModel viewModel) {
    return Container(
      height: 40,
      margin: PaddingConstants.onlyTopSmall,
      child: viewModel.isLoadingSubcategories
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              scrollDirection: Axis.horizontal,
              padding: PaddingConstants.symmetricHorizontalMedium,
              children: [
                // Tümünü gösteren filtre butonu
                _buildFilterChip(
                  context,
                  title: "All",
                  isSelected: viewModel.selectedSubcategoryId == null,
                  onTap: () {
                    viewModel
                        .fetchProductsByCategoryId(widget.categoryModel.id);
                  },
                ),
                // Her alt kategori için bir filtre butonu
                ...viewModel.subcategories.map(
                  (subcategory) => _buildFilterChip(
                    context,
                    title: subcategory.title,
                    isSelected:
                        viewModel.selectedSubcategoryId == subcategory.id,
                    onTap: () {
                      viewModel.filterProductsBySubcategory(subcategory.id);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  // Filtre butonu widget'ı
  Widget _buildFilterChip(
    BuildContext context, {
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: PaddingConstants.onlyRightSmall,
        padding: PaddingConstants.symmetricHorizontalLarge,
        decoration: BoxDecoration(
          color: isSelected ? context.primary : context.surface,
          borderRadius: GeneralConstants.instance.borderRadiusSmall,
        ),
        child: Center(
          child: Helper(
            text: title,
            color: isSelected ? context.onPrimary : context.onSurface,
            isBold: isSelected,
          ),
        ),
      ),
    );
  }

  // Kategori sayfasının başlığını oluşturur
  Widget _buildTitle(BuildContext context, CategoryViewModel viewModel) {
    // Eğer alt kategori seçili ise, kategori ve alt kategori adını birlikte göster
    final subcategoryName = viewModel.selectedSubcategoryName;

    if (subcategoryName != null) {
      return Content(
        text: "${widget.categoryModel.name} - $subcategoryName",
        color: context.onPrimary,
      );
    }

    // Sadece kategori başlığını göster
    return Content(
      text: widget.categoryModel.name,
      color: context.onPrimary,
    );
  }
}
