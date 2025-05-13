import 'package:flutter/material.dart';
import 'package:peasy/core/components/general_app_bar.dart';
import 'package:peasy/core/components/general_background.dart';
import 'package:peasy/core/components/general_button.dart';
import 'package:peasy/core/components/general_text.dart';
import 'package:peasy/core/constants/constants/general_constants.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/features/cart/viewmodel/cart_view_model.dart';
import 'package:peasy/features/cart/widget/cart_widget.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GeneralBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: GeneralAppBar(),
          body: Consumer<CartViewModel>(
            builder: (context, viewModel, child) {
              final cartItems = viewModel.cartItems;
              if (cartItems.isEmpty) {
                return Center(child: Label(text: 'Your cart is empty'));
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: PaddingConstants.pagePadding,
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: cartItems.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: CartWidget(cartItem: cartItems[index]),
                          );
                        },
                      ),
                      _buildButtons(context, viewModel),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context, CartViewModel viewModel) {
    return Row(
      spacing: 8,
      children: [
        _buildContinueButton(context),
        _buildClearCartButton(viewModel, context),
      ],
    );
  }

  Widget _buildClearCartButton(CartViewModel viewModel, BuildContext context) {
    return IconButton.filled(
      icon: Icon(Icons.delete, color: Colors.white, size: 30),
      onPressed: () {
        viewModel.clearCart();
      },
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.error,
        shape: RoundedRectangleBorder(
          borderRadius: GeneralConstants.instance.borderRadiusSmall,
        ),
        fixedSize: const Size(50, 50),
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return GeneralButton(
      text: "Continue",
      onPressed: () {},
    );
  }
}
