import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peasy/core/constants/constants/general_constants.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:peasy/features/home/model/section_model.dart';
import 'package:peasy/features/home/viewmodel/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: PaddingConstants.pagePadding,
            child: Column(
              children: [
                _buildLogo(),
                _buildSearchField(context),
                _buildSections(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Tüm bölümleri dinamik olarak oluşturur.
  Widget _buildSections(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, homeViewModel, child) {
        return Column(
          children: homeViewModel.sections.map((section) => _buildSection(context, section)).toList(),
        );
      },
    );
  }

  /// Tek bir bölümü oluşturan widget.
  Widget _buildSection(BuildContext context, SectionModel section) {
    return Column(
      children: [
        _buildSectionTitle(section.title),
        SizedBox(
          height: 225,
          child: ListView.builder(
            itemCount: section.categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              final category = section.categories[index];
              return Padding(
                padding: PaddingConstants.onlyRightSmall,
                child: _buildCategoryContainer(
                  context,
                  category.title,
                  category.imagePath,
                  category.description,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Bölüm başlığını oluşturan widget.
  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: GeneralConstants.instance.fontSizeMedium,
            fontWeight: GeneralConstants.instance.fontWeightRegular,
          ),
        ),
        TextButton(onPressed: () {}, child: const Text('View All')),
      ],
    );
  }

  /// Uygulama logosunu oluşturan widget.
  Widget _buildLogo() {
    return SizedBox(
      width: double.infinity,
      height: 30,
      child: Image.asset('assets/images/logo.png'),
    );
  }

  /// Arama çubuğunu oluşturan widget.
  Widget _buildSearchField(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextField(
        decoration: InputDecoration(
          contentPadding: PaddingConstants.allMedium + const EdgeInsets.only(left: 32),
          filled: true,
          fillColor: context.surface,
          hintText: 'Search',
          border: GeneralConstants.instance.outlineInputBorder,
        ),
      ),
    );
  }

  /// Kategori kartını oluşturan widget.
  Widget _buildCategoryContainer(BuildContext context, String title, String imagePath, String description) {
    return Container(
      width: 180,
      padding: PaddingConstants.allSmall,
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.2),
        borderRadius: GeneralConstants.instance.borderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryImage(imagePath),
          _buildCategoryTitle(title),
          _buildCategoryDescription(context, description),
        ],
      ),
    );
  }

  /// Kategori resmini oluşturan widget.
  Widget _buildCategoryImage(String imagePath) {
    return Expanded(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: GeneralConstants.instance.borderRadius,
            color: Colors.amber.withOpacity(0.4),
          ),
          child: Image.asset(imagePath),
        ),
      ),
    );
  }

  /// Kategori başlığını oluşturan widget.
  Widget _buildCategoryTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.montserrat(
        fontSize: GeneralConstants.instance.fontSizeMedium,
        fontWeight: GeneralConstants.instance.fontWeightRegular,
      ),
    );
  }

  /// Kategori açıklamasını oluşturan widget.
  Widget _buildCategoryDescription(BuildContext context, String description) {
    return Text(
      description,
      style: GoogleFonts.montserrat(
        fontSize: GeneralConstants.instance.fontSizeExtraSmall,
        fontWeight: GeneralConstants.instance.fontWeightRegular,
        color: context.secondary,
      ),
    );
  }
}
