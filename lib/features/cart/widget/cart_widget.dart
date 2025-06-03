import 'package:flutter/material.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:peasy/features/cart/model/cart_model.dart';

class CartWidget extends StatelessWidget {
  final CartModel cartItem;
  const CartWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildProductImage(context),
          const SizedBox(width: 12),
          Expanded(child: _buildProductInfo(context)),
          _buildPriceAndQuantity(context),
        ],
      ),
    );
  }

  Widget _buildProductInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          cartItem.name ?? '',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: context.onSurface,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        if (cartItem.description != null) ...[
          const SizedBox(height: 4),
          Text(
            cartItem.description!,
            style: TextStyle(
              fontSize: 14,
              color: context.onSurface.withOpacity(0.6),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: context.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '${cartItem.quantity} adet',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: context.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductImage(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.onSurface.withOpacity(0.1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: cartItem.imgPath != null
            ? Image.network(
                cartItem.imgPath!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildPlaceholder(context);
                },
              )
            : _buildPlaceholder(context),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        Icons.shopping_bag_outlined,
        size: 30,
        color: context.primary.withOpacity(0.5),
      ),
    );
  }

  Widget _buildPriceAndQuantity(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Toplam Fiyat
        Text(
          '₺${cartItem.totalPrice.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: context.primary,
          ),
        ),
        if (cartItem.quantity > 1) ...[
          const SizedBox(height: 4),
          Text(
            '₺${cartItem.price?.toStringAsFixed(2) ?? "0"} / adet',
            style: TextStyle(
              fontSize: 12,
              color: context.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ],
    );
  }
}
