import 'package:flutter/material.dart';
import 'package:peasy/core/components/general_divider.dart';
import 'package:peasy/core/components/general_text.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:peasy/core/init/network/auth_service.dart';
import 'package:peasy/features/cart/view/cart_view.dart';
import 'package:peasy/features/home/view/home_view.dart';
import 'package:peasy/features/navigation/viewmodel/navigation_view_model.dart';
import 'package:peasy/features/nfc/view/nfc_view.dart';
import 'package:provider/provider.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => NavigationViewState();
}

class NavigationViewState extends State<NavigationView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    NavigationViewModel.setScaffoldKey(scaffoldKey);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          key: scaffoldKey,
          drawer: _buildDrawer(context),
          body: _buildBody(viewModel),
        );
      },
    );
  }

  /// Builds the drawer widget with menu items.
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      width: context.width * 0.6,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [context.primary, Color(0xFF002A73)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: ListView(
            physics: ClampingScrollPhysics(),
            padding: PaddingConstants.symmetricHorizontalMedium,
            children: [
              _buildDrawerHeader(context),
              GeneralDivider(),
              _buildDrawerMenuItem(
                  context, Icons.account_circle, 'Profile', () {}),
              _buildDrawerMenuItem(context, Icons.payment, 'Payment', () {}),
              _buildDrawerMenuItem(context, Icons.settings, 'Settings', () {}),
              GeneralDivider(),
              _buildDrawerMenuItem(context, Icons.info, 'Information', () {}),
              _buildDrawerMenuItem(
                  context, Icons.contact_mail, 'Contact us', () {}),
              _buildDrawerMenuItem(
                  context, Icons.info_outline, 'About us', () {}),
              GeneralDivider(),
              _buildDrawerMenuItem(context, Icons.logout, 'Log out', () {
                // Handle logout action
                AuthService().signOut();
                Navigator.pop(context);
              }),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the header for the drawer.
  Widget _buildDrawerHeader(BuildContext context) {
    return Container(
      padding: PaddingConstants.symmetricVerticalMedium,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Image.asset('assets/images/logo.png',
                  height: 30, color: context.onPrimary)),
          const SizedBox(height: 32),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Content(
                text: "Welcome, back!",
                color: context.onPrimary,
              ),
              Helper(
                text: "Name Surname",
                color: context.onPrimary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds a menu item for the drawer.
  Widget _buildDrawerMenuItem(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      contentPadding: PaddingConstants.zeroPadding,
      leading: Icon(icon, color: context.onPrimary),
      title: Text(title, style: TextStyle(color: context.onPrimary)),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }

  Widget _buildBody(NavigationViewModel viewModel) {
    return Consumer<NavigationViewModel>(
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
                  NFCView(),
                  Placeholder(color: Colors.purple),
                  CartView(),
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
  Widget _buildCustomNavBar(NavigationViewModel viewModel) {
    return Consumer<NavigationViewModel>(
      builder: (context, navigationViewModel, child) {
        return AnimatedSlide(
          offset: navigationViewModel.selectedIndex != 2 &&
                  navigationViewModel.selectedIndex != 4
              ? Offset(0, 0)
              : Offset(0, 1),
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          child: Padding(
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
          ),
        );
      },
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
    final iconColor = isSelected
        ? context.onPrimary
        : context.onPrimary.withValues(alpha: 0.5);

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
