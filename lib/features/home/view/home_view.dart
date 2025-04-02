import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peasy/core/constants/constants/general_constants.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:peasy/features/home/widget/advertisement_widget.dart';
import 'package:peasy/features/home/widget/category_section_widget.dart';
import 'package:peasy/features/home/viewmodel/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, homeViewModel, child) {
        return Scaffold(
          appBar: _buildAppBar(context),
          body: _buildBody(context),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: Icon(Icons.menu, color: context.onPrimary),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.shopping_cart, color: context.primary),
        ),
      ],
      backgroundColor: context.primary,
      title: _buildLogo(context),
      centerTitle: true,
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
        CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            _buildSliverAppBar(context),
            SliverPadding(
              padding: PaddingConstants.pagePadding,
              sliver: SliverToBoxAdapter(
                child: Column(
                  spacing: 16,
                  children: [
                    AdvertisementWidget(),
                    _buildSections(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Builds the sliver app bar with search field
  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      floating: true,
      snap: true,
      toolbarHeight: 80,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            color: context.primary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: PaddingConstants.allMedium,
            child: _buildSearchTextField(context),
          ),
        ),
      ),
    );
  }

  /// Builds the sections of the HomeView dynamically.
  Widget _buildSections(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, homeViewModel, child) {
        return Column(
          spacing: 20,
          children: homeViewModel.sections.map((section) {
            return CategorySectionWidget(section: section);
          }).toList(),
        );
      },
    );
  }

  /// Builds the application logo widget.
  Widget _buildLogo(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 24,
      child: Image.asset(
        'assets/images/logo.png',
        color: context.onPrimary,
      ),
    );
  }

  /// Builds the search text field.
  Widget _buildSearchTextField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        prefixIcon: Icon(Icons.search, color: context.secondary, size: 32),
        contentPadding: PaddingConstants.allMedium,
        fillColor: context.surface,
        hintText: 'Search for a product, grocery...',
        hintStyle: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: context.secondary,
        ),
        border: OutlineInputBorder(
          borderRadius: GeneralConstants.instance.borderRadiusMedium,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: GeneralConstants.instance.borderRadiusMedium,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: GeneralConstants.instance.borderRadiusMedium,
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
