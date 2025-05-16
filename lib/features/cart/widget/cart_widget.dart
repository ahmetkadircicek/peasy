import 'package:flutter/material.dart';
import 'package:peasy/core/components/general_text.dart';
import 'package:peasy/core/constants/constants/general_constants.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:peasy/features/cart/model/cart_model.dart';
import 'package:peasy/features/cart/viewmodel/cart_view_model.dart';
import 'package:provider/provider.dart';

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
        spacing: 8,
        children: [
          _buildProductImage(context),
          Expanded(child: _buildName(context)),
          Expanded(child: _buildQuantity(context)),
          _buildQuantityControls(context),
        ],
      ),
    );
  }

  Row _buildQuantity(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Fiyat Bilgisi
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Content(
              text: '₺${cartItem.totalPrice.toStringAsFixed(2)}',
              color: context.primary,
              isBold: true,
            ),
            if (cartItem.quantity > 1)
              Label(
                text:
                    '${cartItem.quantity}x ₺${cartItem.price.toStringAsFixed(2)}',
                color: context.onSurface.withOpacity(0.6),
              ),
          ],
        ),
        // Miktar Kontrolleri
      ],
    );
  }

  Row _buildName(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Content(
              text: cartItem.name,
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
        ),
      ],
    );
  }

  // Ürün Resmi
  Widget _buildProductImage(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      margin: PaddingConstants.onlyLeftSmall,
      decoration: BoxDecoration(
        borderRadius: GeneralConstants.instance.borderRadiusMedium,
        image: DecorationImage(
          image: AssetImage(cartItem.imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // // Kaldır Butonu
  // Widget _buildRemoveButton(BuildContext context) {
  //   return IconButton(
  //     icon: Icon(
  //       Icons.delete_outline,
  //       color: Theme.of(context).colorScheme.error,
  //     ),
  //     onPressed: () {
  //       // Onay iletişim kutusu göster
  //       showDialog(
  //         context: context,
  //         builder: (context) => AlertDialog(
  //           title: const Text('Ürünü Kaldır'),
  //           content: Text(
  //               '${cartItem.name} ürününü sepetten kaldırmak istediğinizden emin misiniz?'),
  //           actions: [
  //             TextButton(
  //               onPressed: () => Navigator.pop(context),
  //               child: const Text('İptal'),
  //             ),
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //                 context.read<CartViewModel>().removeItem(cartItem.id);
  //               },
  //               child: Text(
  //                 'Kaldır',
  //                 style: TextStyle(color: Theme.of(context).colorScheme.error),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // Miktar Kontrolleri
  Widget _buildQuantityControls(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.primary,
      ),
      child: Column(
        children: [
          // Artır Butonu
          _buildQuantityButton(
            context,
            icon: Icons.add,
            onPressed: () {
              context.read<CartViewModel>().incrementQuantity(cartItem.id);
            },
          ),
          // Miktar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '${cartItem.quantity}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: context.onPrimary,
              ),
            ),
          ),
          // Azalt Butonu
          _buildQuantityButton(
            context,
            icon: Icons.remove,
            onPressed: () {
              context.read<CartViewModel>().decrementQuantity(cartItem.id);
            },
          ),
        ],
      ),
    );
  }

  // Miktar Butonu
  Widget _buildQuantityButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Icon(
          icon,
          size: 18,
          color: context.onPrimary,
        ),
      ),
    );
  }
}
