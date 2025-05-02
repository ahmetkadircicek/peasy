import 'package:flutter/material.dart';
import 'package:peasy/core/components/general_text.dart';
import 'package:peasy/core/constants/constants/general_constants.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:peasy/features/cart/model/cart_model.dart';

class CartWidget extends StatelessWidget {
  final CartModel cartItem;
  const CartWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PaddingConstants.allSmall,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: GeneralConstants.instance.borderRadiusMedium,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCartItemInfo(cartItem, context),
          _buildCartItemPrice(cartItem.price, context),
          _buildCartItemQuantity(cartItem.quantity, context),
          _buildCartItemTotalPrice(cartItem.totalPrice, context),
        ],
      ),
    );
  }

  Widget _buildCartItemInfo(CartModel item, BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        _buildCartItemImage(item.imagePath),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCartItemTitle(item.name),
            _buildCartItemId(context, item.id),
          ],
        ),
      ],
    );
  }

  /// Builds the product image widget.
  Widget _buildCartItemImage(String imagePath) {
    return Image.asset(imagePath);
  }

  /// Builds the product ID widget.
  Widget _buildCartItemId(BuildContext context, String id) {
    return Label(
      text: id,
      color: context.secondary,
    );
  }

  Widget _buildCartItemTitle(String title) {
    return Helper(text: title);
  }

  /// Builds the product quantity widget.
  Widget _buildCartItemQuantity(int quantity, BuildContext context) {
    return Helper(text: quantity.toString(), color: context.primary);
  }

  /// Builds the product price widget.
  Widget _buildCartItemPrice(double price, BuildContext context) {
    return Helper(
        text: '\$${price.toStringAsFixed(2)}', color: context.primary);
  }

  /// Builds the product total price widget.
  Widget _buildCartItemTotalPrice(double totalPrice, BuildContext context) {
    return Helper(
        text: '\$${totalPrice.toStringAsFixed(2)}', color: context.primary);
  }
}
