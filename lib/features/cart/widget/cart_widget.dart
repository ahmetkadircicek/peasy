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
      width: double.infinity,
      margin: PaddingConstants.onlyBottomSmall,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: GeneralConstants.instance.borderRadiusMedium,
      ),
      child: Row(
        children: [
          _buildProductImage(context),
          const SizedBox(width: 8),
          Expanded(child: _buildName(context)),
          _buildQuantityInfo(context),
          const SizedBox(width: 12),
        ],
      ),
    );
  }

  Widget _buildName(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Content(
          text: cartItem.name ?? '',
          isBold: true,
          maxLines: 1,
        ),
        if (cartItem.description != null)
          Label(
            text: cartItem.description!,
            color: context.onSurface.withOpacity(0.6),
            maxLines: 1,
          ),
      ],
    );
  }

  Widget _buildProductImage(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      margin: PaddingConstants.onlyLeftSmall,
      decoration: BoxDecoration(
        borderRadius: GeneralConstants.instance.borderRadiusMedium,
        image: DecorationImage(
          image: AssetImage(cartItem.imgPath ?? 'assets/default.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildQuantityInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Content(
          text: '₺${cartItem.totalPrice.toStringAsFixed(2)}',
          color: context.primary,
          isBold: true,
        ),
        if (cartItem.quantity > 1)
          Label(
            text:
                '${cartItem.quantity} x ₺${cartItem.price?.toStringAsFixed(2) ?? "0"}',
            color: context.onSurface.withOpacity(0.6),
          ),
      ],
    );
  }
}
