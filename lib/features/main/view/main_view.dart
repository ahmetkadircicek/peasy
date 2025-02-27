import 'package:flutter/material.dart';
import 'package:peasy/core/components/general_text.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:peasy/features/home/view/home_view.dart';
import 'package:peasy/features/main/viewmodel/main_view_model.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => MainViewState();
}

class MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          body: _buildBody(viewModel),
        );
      },
    );
  }

  Widget _buildBody(MainViewModel viewModel) {
    return Consumer<MainViewModel>(
      builder: (context, viewModel, child) {
        return Stack(
          children: [
            Positioned.fill(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: viewModel.pageController,
                onPageChanged: viewModel.onPageChanged,
                children: const [
                  HomeView(),
                  Placeholder(color: Colors.blue),
                  Placeholder(color: Colors.green),
                  Placeholder(color: Colors.purple),
                  Placeholder(color: Colors.amber),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildCustomNavBar(viewModel),
            ),
          ],
        );
      },
    );
  }

  /// Builds the custom navigation bar with navigation items.
  Widget _buildCustomNavBar(MainViewModel viewModel) {
    return Padding(
      padding: PaddingConstants.allSmall,
      child: Container(
        padding: PaddingConstants.symmetricHorizontalSmall,
        height: 60,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: context.primary,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavBarItem(
              icon: Icons.home,
              text: 'Home',
              index: 0,
              selectedIndex: viewModel.selectedIndex,
              onTap: () => viewModel.onItemTapped(0),
              context: context,
            ),
            _buildNavBarItem(
              icon: Icons.discount,
              text: 'Sales',
              index: 1,
              selectedIndex: viewModel.selectedIndex,
              onTap: () => viewModel.onItemTapped(1),
              context: context,
            ),
            _buildCenterNavBarItem(
              icon: Icons.barcode_reader,
              onTap: () => viewModel.onItemTapped(2),
              context: context,
            ),
            _buildNavBarItem(
              index: 3,
              icon: Icons.receipt_long,
              text: 'Receipts',
              selectedIndex: viewModel.selectedIndex,
              onTap: () => viewModel.onItemTapped(3),
              context: context,
            ),
            _buildNavBarItem(
              icon: Icons.shopping_cart,
              text: 'Cart',
              index: 4,
              selectedIndex: viewModel.selectedIndex,
              onTap: () => viewModel.onItemTapped(4),
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavBarItem({
    required IconData icon,
    required String text,
    required int index,
    required int selectedIndex,
    required Function() onTap,
    required BuildContext context,
  }) {
    final isSelected = index == selectedIndex;
    final iconColor = isSelected ? context.onPrimary : context.onPrimary.withValues(alpha: 0.5);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor),
          Label(text: text, color: iconColor, isBold: true),
        ],
      ),
    );
  }

  Widget _buildCenterNavBarItem({
    required IconData icon,
    required Function() onTap,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 26,
        backgroundColor: context.onPrimary,
        child: Icon(icon, color: context.primary, size: 30),
      ),
    );
  }
}
