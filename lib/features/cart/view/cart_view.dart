import 'package:flutter/material.dart';
import 'package:peasy/core/components/general_app_bar.dart';
import 'package:peasy/core/components/general_background.dart';
import 'package:peasy/core/components/general_button.dart';
import 'package:peasy/core/components/general_text.dart';
import 'package:peasy/core/constants/constants/general_constants.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:peasy/features/cart/model/cart_model.dart';
import 'package:peasy/features/cart/viewmodel/cart_view_model.dart';
import 'package:peasy/features/cart/widget/cart_widget.dart';
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
        _buildCartContentBody(context, viewModel),
        _buildBottomBar(context, viewModel),
      ],
    );
  }

  Widget _buildCartContentBody(BuildContext context, CartViewModel viewModel) {
    return Expanded(
      child: SingleChildScrollView(
        padding: PaddingConstants.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCartSummary(context, viewModel),
            const SizedBox(height: 16),
            _buildCartItems(context, viewModel),
          ],
        ),
      ),
    );
  }

  // Boş Sepet
  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildEmptyCartIcon(context),
          const SizedBox(height: 16),
          _buildEmptyCartTitle(),
          const SizedBox(height: 8),
          _buildEmptyCartDescription(),
          const SizedBox(height: 24),
          _buildEmptyCartButtons(context),
        ],
      ),
    );
  }

  Widget _buildEmptyCartIcon(BuildContext context) {
    return Icon(
      Icons.shopping_cart_outlined,
      size: 80,
      color: context.primary.withOpacity(0.5),
    );
  }

  Widget _buildEmptyCartTitle() {
    return const Headline(
      text: 'Sepetiniz Boş',
      isCentred: true,
    );
  }

  Widget _buildEmptyCartDescription() {
    return const Content(
      text: 'Alışverişe başlamak için ürün ekleyin',
      isCentred: true,
    );
  }

  Widget _buildEmptyCartButtons(BuildContext context) {
    return Padding(
      padding: PaddingConstants.symmetricHorizontalLarge,
      child: Column(
        children: [
          _buildShoppingButton(context),
        ],
      ),
    );
  }

  Widget _buildShoppingButton(BuildContext context) {
    return GeneralButton(
      text: 'Alışverişe Başla',
      onPressed: () {
        // Ana sayfaya yönlendir
        Navigator.pop(context);
      },
    );
  }

  // Sepet Özeti
  Widget _buildCartSummary(BuildContext context, CartViewModel viewModel) {
    return Container(
      padding: PaddingConstants.allMedium,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: GeneralConstants.instance.borderRadiusMedium,
      ),
      child: Column(
        children: [
          _buildCartSummaryHeader(context, viewModel),
          const Divider(),
          _buildCartSummaryDetails(context, viewModel),
          _buildExpandCollapseButton(context, viewModel),
        ],
      ),
    );
  }

  Widget _buildCartSummaryHeader(
      BuildContext context, CartViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Headline(text: 'Sepet Özeti'),
        _buildClearCartButton(context, viewModel),
      ],
    );
  }

  Widget _buildClearCartButton(BuildContext context, CartViewModel viewModel) {
    return TextButton.icon(
      onPressed: () => _showClearCartDialog(context, viewModel),
      icon: Icon(
        Icons.delete_outline,
        color: Theme.of(context).colorScheme.error,
      ),
      label: Text(
        'Temizle',
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
    );
  }

  Widget _buildCartSummaryDetails(
      BuildContext context, CartViewModel viewModel) {
    return Column(
      children: [
        _buildSummaryRow(context, 'Toplam Ürün', '${viewModel.itemCount} ürün'),
        _buildSummaryRow(
            context, 'Toplam Adet', '${viewModel.totalItems} adet'),
        _buildSummaryRow(
          context,
          'Ara Toplam',
          '₺${viewModel.subtotal.toStringAsFixed(2)}',
          valueColor: context.primary,
        ),
      ],
    );
  }

  Widget _buildExpandCollapseButton(
      BuildContext context, CartViewModel viewModel) {
    return TextButton(
      onPressed: viewModel.toggleExpanded,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            viewModel.isExpanded ? 'Daralt' : 'Detayları Göster',
            style: TextStyle(color: context.primary),
          ),
          Icon(
            viewModel.isExpanded
                ? Icons.keyboard_arrow_up
                : Icons.keyboard_arrow_down,
            color: context.primary,
          ),
        ],
      ),
    );
  }

  // Özet Satırı
  Widget _buildSummaryRow(
    BuildContext context,
    String label,
    String value, {
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Helper(text: label),
          Helper(
            text: value,
            color: valueColor,
            isBold: valueColor != null,
          ),
        ],
      ),
    );
  }

  // Sepet Öğeleri
  Widget _buildCartItems(BuildContext context, CartViewModel viewModel) {
    if (viewModel.isExpanded) {
      return _buildExpandedCartItems(context, viewModel);
    } else {
      return _buildCollapsedCartItems(context, viewModel);
    }
  }

  Widget _buildExpandedCartItems(
      BuildContext context, CartViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: viewModel.groupedItems.entries.map((entry) {
        return _buildCategorySection(context, entry.key, entry.value);
      }).toList(),
    );
  }

  Widget _buildCategorySection(
      BuildContext context, String category, List<CartModel> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCategoryHeader(category),
        ...items.map((item) => CartWidget(cartItem: item)),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildCategoryHeader(String category) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SubHeadline(text: category),
    );
  }

  Widget _buildCollapsedCartItems(
      BuildContext context, CartViewModel viewModel) {
    final displayItems = viewModel.cartItems.take(0).toList();
    final remainingCount = viewModel.cartItems.length - displayItems.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...displayItems.map((item) => CartWidget(cartItem: item)),
        if (remainingCount > 0)
          _buildRemainingItemsIndicator(context, viewModel, remainingCount),
      ],
    );
  }

  Widget _buildRemainingItemsIndicator(
      BuildContext context, CartViewModel viewModel, int remainingCount) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: PaddingConstants.allMedium,
      decoration: BoxDecoration(
        color: context.primary.withOpacity(0.1),
        borderRadius: GeneralConstants.instance.borderRadiusMedium,
      ),
      child: Row(
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            color: context.primary,
          ),
          const SizedBox(width: 8),
          Helper(
            text: 'Ve $remainingCount ürün daha...',
            color: context.primary,
          ),
          const Spacer(),
          TextButton(
            onPressed: viewModel.toggleExpanded,
            child: const Text('Tümünü Gör'),
          ),
        ],
      ),
    );
  }

  // Alt Kısım: Toplam ve Ödeme Butonu
  Widget _buildBottomBar(BuildContext context, CartViewModel viewModel) {
    return Container(
      padding: PaddingConstants.allMedium,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
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
            _buildPriceDetails(context, viewModel),
            const Divider(height: 16),
            _buildTotalAndCheckoutRow(context, viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceDetails(BuildContext context, CartViewModel viewModel) {
    return Column(
      children: [
        _buildSubtotalRow(context, viewModel),
        _buildTaxRow(context, viewModel),
        _buildShippingRow(context, viewModel),
      ],
    );
  }

  Widget _buildSubtotalRow(BuildContext context, CartViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Content(text: 'Ara Toplam:'),
        Content(
          text: '₺${viewModel.subtotal.toStringAsFixed(2)}',
          color: context.primary,
        ),
      ],
    );
  }

  Widget _buildTaxRow(BuildContext context, CartViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Helper(text: 'KDV (%18):'),
        Helper(
          text: '₺${viewModel.tax.toStringAsFixed(2)}',
        ),
      ],
    );
  }

  Widget _buildShippingRow(BuildContext context, CartViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Helper(
          text: viewModel.shipping > 0
              ? 'Kargo:'
              : 'Kargo (100₺ üzeri ücretsiz):',
        ),
        Helper(
          text: viewModel.shipping > 0
              ? '₺${viewModel.shipping.toStringAsFixed(2)}'
              : 'Ücretsiz',
          color: viewModel.shipping > 0 ? null : Colors.green,
        ),
      ],
    );
  }

  Widget _buildTotalAndCheckoutRow(
      BuildContext context, CartViewModel viewModel) {
    return Row(
      children: [
        _buildTotalPrice(context, viewModel),
        _buildCheckoutButton(context),
      ],
    );
  }

  Widget _buildTotalPrice(BuildContext context, CartViewModel viewModel) {
    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Label(text: 'Toplam Tutar'),
          Headline(
            text: '₺${viewModel.total.toStringAsFixed(2)}',
            color: context.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return Expanded(
      flex: 3,
      child: GeneralButton(
        text: 'Ödemeye Geç',
        icon: Icons.payment,
        onPressed: () {
          _handleCheckout(context);
        },
      ),
    );
  }

  void _handleCheckout(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ödeme işlemi başlatılıyor...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Sepeti Temizle Dialog
  void _showClearCartDialog(BuildContext context, CartViewModel viewModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sepeti Temizle'),
        content: const Text(
            'Sepetinizdeki tüm ürünleri kaldırmak istediğinizden emin misiniz?'),
        actions: [
          _buildCancelButton(context),
          _buildConfirmClearButton(context, viewModel),
        ],
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: const Text('İptal'),
    );
  }

  Widget _buildConfirmClearButton(
      BuildContext context, CartViewModel viewModel) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
        viewModel.clearCart();
      },
      child: Text(
        'Temizle',
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
    );
  }
}
