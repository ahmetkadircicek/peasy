import 'package:flutter/material.dart';
import 'package:peasy/core/components/general_app_bar.dart';
import 'package:peasy/core/components/general_background.dart';
import 'package:peasy/core/components/general_button.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:peasy/features/cart/viewmodel/cart_view_model.dart';
import 'package:peasy/features/cart/widget/cart_widget.dart';
import 'package:peasy/features/payment/model/payment_model.dart';
import 'package:peasy/features/payment/view/payment_view.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildMainLayout(context);
  }

  Widget _buildMainLayout(BuildContext context) {
    return Stack(
      children: [
        const GeneralBackground(),
        _buildScaffold(context),
      ],
    );
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const GeneralAppBar(title: 'Sepetim'),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Consumer<CartViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return _buildLoadingIndicator();
        }

        final cartItems = viewModel.cartItems;
        if (cartItems.isEmpty) {
          return _buildEmptyCart(context);
        }

        return _buildCartContent(context, viewModel);
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildCartContent(BuildContext context, CartViewModel viewModel) {
    return Column(
      children: [
        Expanded(
          child: _buildCartItems(context, viewModel),
        ),
        _buildBottomBar(context, viewModel),
      ],
    );
  }

  // Boş Sepet
  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: context.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 24),
          Text(
            'Sepetiniz Boş',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: context.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Alışverişe başlamak için ürün ekleyin',
            style: TextStyle(
              fontSize: 16,
              color: context.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: GeneralButton(
              text: 'Alışverişe Başla',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Sepet Öğeleri - Swipe to Delete ile
  Widget _buildCartItems(BuildContext context, CartViewModel viewModel) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: viewModel.cartItems.length,
      itemBuilder: (context, index) {
        final cartItem = viewModel.cartItems[index];

        return Dismissible(
          key: Key(cartItem.productId ?? index.toString()),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
              size: 28,
            ),
          ),
          confirmDismiss: (direction) async {
            return await _showDeleteConfirmDialog(
                context, cartItem.name ?? 'Bu ürün');
          },
          onDismissed: (direction) {
            viewModel.removeItem(cartItem.productId ?? '');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${cartItem.name} sepetten kaldırıldı'),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                duration: const Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'Geri Al',
                  textColor: Colors.white,
                  onPressed: () {
                    viewModel.addItem(cartItem);
                  },
                ),
              ),
            );
          },
          child: CartWidget(cartItem: cartItem),
        );
      },
    );
  }

  // Silme Onay Dialog'u
  Future<bool?> _showDeleteConfirmDialog(
      BuildContext context, String productName) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ürünü Kaldır'),
          content: Text(
              '$productName\'ı sepetten kaldırmak istediğinizden emin misiniz?'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'İptal',
                style: TextStyle(color: context.onSurface.withOpacity(0.6)),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'Kaldır',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }

  // Alt Kısım: Toplam ve Ödeme Butonu - Kargo Kaldırıldı
  Widget _buildBottomBar(BuildContext context, CartViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildOrderSummary(context, viewModel),
            const SizedBox(height: 16),
            _buildCheckoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context, CartViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.onSurface.withOpacity(0.03),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ara Toplam',
                style: TextStyle(
                  fontSize: 16,
                  color: context.onSurface.withOpacity(0.7),
                ),
              ),
              Text(
                '₺${viewModel.subtotal.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: context.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'KDV (%18)',
                style: TextStyle(
                  fontSize: 14,
                  color: context.onSurface.withOpacity(0.7),
                ),
              ),
              Text(
                '₺${viewModel.tax.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 14,
                  color: context.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Toplam',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: context.onSurface,
                ),
              ),
              Text(
                '₺${(viewModel.subtotal + viewModel.tax).toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: context.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: GeneralButton(
        text: 'Ödemeye Geç',
        icon: Icons.arrow_forward_ios,
        onPressed: () {
          _handleCheckout(context);
        },
      ),
    );
  }

  void _handleCheckout(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context, listen: false);

    if (cartViewModel.cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Sepetiniz boş. Önce ürün ekleyin.'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    // Convert CartModel items to OrderItem for payment
    final orderItems = cartViewModel.cartItems.map((cartItem) {
      return OrderItem(
        id: cartItem.productId ?? '',
        name: cartItem.name ?? 'Ürün',
        price: cartItem.price ?? 0.0,
        quantity: cartItem.quantity,
        imageUrl: cartItem.imgPath,
      );
    }).toList();

    // Navigate to PaymentView with cart items and cart clearing callback
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PaymentViewWrapper(
          orderItems: orderItems,
          onPaymentSuccess: () {
            cartViewModel.clearCart();
          },
        ),
      ),
    );
  }
}
