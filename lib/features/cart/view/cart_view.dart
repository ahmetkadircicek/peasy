import 'package:flutter/material.dart';
import 'package:peasy/core/components/general_text.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/widgets/background.dart';
import 'package:peasy/core/widgets/general_app_bar.dart';
import 'package:peasy/core/widgets/main_button.dart';
import 'package:peasy/features/cart/viewmodel/cart_view_model.dart';
import 'package:peasy/features/cart/widget/cart_widget.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: GeneralAppBar(),
          body: Consumer<CartViewModel>(
            builder: (context, viewModel, child) {
              final cartItems = viewModel.cartItems;

              if (cartItems.isEmpty) {
                return Center(child: Label(text: 'Your cart is empty'));
              }
              return Column(
                children: [
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverPadding(
                          padding: PaddingConstants.pagePadding,
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: CartWidget(cartItem: cartItems[index]),
                                );
                              },
                              childCount: cartItems.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  _buildContinueButton(context),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.006,
                  ),
                  _buildClearCartButton(viewModel, context),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.095,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildClearCartButton(CartViewModel viewModel, BuildContext context) {
    return Padding(
      padding: PaddingConstants.symmetricHorizontalMedium,
      child: MainButton(
        text: "Clear Cart",
        onPressed: () {
          viewModel.clearCart();
        },
        height: MediaQuery.of(context).size.height * 0.05,
        color: Colors.transparent,
        textColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Padding(
      padding: PaddingConstants.symmetricHorizontalMedium,
      child: MainButton(
        text: "Continue",
        onPressed: () {},
        height: MediaQuery.of(context).size.height * 0.05,
      ),
    );
  }
}
