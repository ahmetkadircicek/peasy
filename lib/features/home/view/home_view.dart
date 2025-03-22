import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peasy/core/components/general_text.dart';
import 'package:peasy/core/constants/constants/general_constants.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:peasy/features/home/model/category_model.dart';
import 'package:peasy/features/home/model/section_model.dart';
import 'package:peasy/features/home/viewmodel/home_view_model.dart';
import 'package:peasy/features/main/viewmodel/main_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, homeViewModel, child) {
        return Scaffold(
          body: _buildBody(context),
        );
      },
    );
  }

  /// Builds the main body of the HomeView.
  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/background_vector.png',
            fit: BoxFit.cover,
          ),
        ),
        SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: PaddingConstants.pagePadding,
              child: Column(
                spacing: 16,
                children: [
                  _buildLogo(),
                  _buildSearchField(context),
                  _buildSections(context),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the sections of the HomeView dynamically.
  Widget _buildSections(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, homeViewModel, child) {
        return Column(
          spacing: 20,
          children: homeViewModel.sections.map((section) => _buildSection(context, section)).toList(),
        );
      },
    );
  }

  /// Builds a single section widget.
  Widget _buildSection(BuildContext context, SectionModel section) {
    return Column(
      spacing: 4,
      children: [
        _buildSectionTitle(context, section.title),
        _buildCategoryList(section.categories),
      ],
    );
  }

  /// Builds the list of categories for a section.
  Widget _buildCategoryList(List<CategoryModel> categories) {
    return SizedBox(
      height: 225,
      child: ListView.builder(
        clipBehavior: Clip.none,
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        physics: ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final category = categories[index];
          return Padding(
            padding: PaddingConstants.onlyRightSmall,
            child: _buildCategoryContainer(context, category),
          );
        },
      ),
    );
  }

  /// Builds the category container widget.
  Widget _buildCategoryContainer(BuildContext context, CategoryModel category) {
    return Container(
      width: 180,
      padding: PaddingConstants.allSmall,
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: GeneralConstants.instance.borderRadius,
      ),
      child: Column(
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
    return Expanded(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: GeneralConstants.instance.borderRadius,
            color: Colors.amber.withValues(alpha: 0.4),
          ),
          child: Image.asset(imagePath),
        ),
      ),
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
    );
  }

  /// Builds the application logo widget.
  Widget _buildLogo() {
    return SizedBox(
      width: double.infinity,
      height: 24,
      child: Image.asset('assets/images/logo.png'),
    );
  }

  /// Builds the search field widget.
  Widget _buildSearchField(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildSearchTextField(context),
          _buildDrawerToggleButton(context),
          _buildSearchButton(context),
        ],
      ),
    );
  }

  /// Builds the search text field.
  Widget _buildSearchTextField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: PaddingConstants.allMedium + const EdgeInsets.only(left: 48),
        filled: true,
        fillColor: context.surface,
        hintText: 'Search for a product, grocery...',
        hintStyle: GoogleFonts.montserrat(
          fontSize: GeneralConstants.instance.fontSizeMedium,
          fontWeight: GeneralConstants.instance.fontWeightRegular,
          color: context.secondary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  /// Builds the button to toggle the drawer.
  Widget _buildDrawerToggleButton(BuildContext context) {
    return Positioned(
      left: 0,
      child: GestureDetector(
        onTap: () {
          MainViewModel.openDrawer();
        },
        child: CircleAvatar(
          radius: 27,
          backgroundColor: context.primaryColor,
          child: Icon(Icons.menu, color: Colors.white),
        ),
      ),
    );
  }

  /// Builds the search button.
  Widget _buildSearchButton(BuildContext context) {
    return Positioned(
      right: 0,
      child: CircleAvatar(
        radius: 27,
        backgroundColor: context.primaryColor,
        child: Icon(Icons.search, color: Colors.white), // Search icon
      ),
    );
  }

  /// Bölüm başlığını oluşturan widget.
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Content(
          text: title,
        ),
        GestureDetector(
          onTap: () {},
          child: Helper(
            text: 'View All',
            color: context.primary,
          ),
        )
      ],
    );
  }
}
