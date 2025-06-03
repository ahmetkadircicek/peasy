import 'package:flutter/material.dart';
import 'package:peasy/core/components/general_app_bar.dart';
import 'package:peasy/core/components/general_background.dart';
import 'package:peasy/core/components/general_button.dart';
import 'package:peasy/core/components/general_text.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/constants/enums/product_status_enum.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:peasy/features/cart/model/cart_model.dart';
import 'package:peasy/features/cart/view/cart_view.dart';
import 'package:peasy/features/cart/viewmodel/cart_view_model.dart';
import 'package:peasy/features/nfc/viewmodel/nfc_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class NFCView extends StatefulWidget {
  const NFCView({super.key});

  @override
  State<NFCView> createState() => _NFCViewState();
}

class _NFCViewState extends State<NFCView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NFCViewModel>(context, listen: false).startNFCScan();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  GeneralAppBar _buildAppBar(BuildContext context) {
    return GeneralAppBar(
      title: 'NFC Scanner',
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        GeneralBackground(),
        Consumer<NFCViewModel>(
          builder: (context, viewModel, child) {
            return SafeArea(
              child: SingleChildScrollView(
                padding: PaddingConstants.pagePadding,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom -
                        kToolbarHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        _buildScannerAnimation(context, viewModel),
                        const SizedBox(height: 24),
                        _buildStatusText(viewModel),
                        if (viewModel.isError) ...[
                          const SizedBox(height: 16),
                          _buildErrorMessage(viewModel),
                        ],
                        if (viewModel.product != null) ...[
                          const SizedBox(height: 16),
                          _buildProductInfo(viewModel),
                        ],
                        const Spacer(),
                        const SizedBox(height: 16),
                        _buildActionButton(context, viewModel),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildScannerAnimation(BuildContext context, NFCViewModel viewModel) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.primary.withValues(alpha: 0.2),
      ),
      child: Center(
        child: viewModel.isScanning
            ? Shimmer.fromColors(
                baseColor: context.primary,
                highlightColor: context.onPrimary,
                period: const Duration(seconds: 2),
                child: Image.asset(
                  'assets/images/nfc_icon.png',
                ),
              )
            : Image.asset(
                'assets/images/nfc_icon.png',
              ),
      ),
    );
  }

  Widget _buildStatusText(NFCViewModel viewModel) {
    String statusMessage = 'Please hold your phone near the NFC tag';

    if (viewModel.isScanning) {
      statusMessage = 'Scanning for NFC tags...';
    } else if (viewModel.product != null) {
      statusMessage = 'Product found!';
    }

    return Content(
      text: statusMessage,
      isBold: true,
    );
  }

  Widget _buildErrorMessage(NFCViewModel viewModel) {
    final errorMessage = viewModel.errorMessage ?? 'An error occurred';
    final isIOSError = errorMessage.contains('iOS NFC servis hatası');

    return Container(
      padding: PaddingConstants.allMedium,
      decoration: BoxDecoration(
        color: isIOSError ? Colors.orange.shade100 : Colors.red.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Content(
            text: isIOSError ? 'iOS NFC Erişim Sorunu' : 'Hata',
            color: isIOSError ? Colors.orange.shade800 : Colors.red.shade800,
            isBold: true,
          ),
          SizedBox(height: 8),
          Content(
            text: errorMessage,
            color: isIOSError ? Colors.orange.shade800 : Colors.red.shade800,
            fontSize: 14,
          ),
        ],
      ),
    );
  }

  Widget _buildProductInfo(NFCViewModel viewModel) {
    final product = viewModel.product!;
    final quantity = product.stock ?? 0;
    final stockStatus = getStockStatusFromQuantity(quantity);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Ürün Adı
          Text(
            product.name ?? 'Ürün Adı',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: context.onSurface,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),

          // Ürün Açıklaması
          if (product.description != null &&
              product.description!.isNotEmpty) ...[
            Text(
              product.description!,
              style: TextStyle(
                fontSize: 14,
                color: context.onSurface.withOpacity(0.7),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
          ],

          // Fiyat ve Stok Durumu
          Row(
            children: [
              // Fiyat Kısmı
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fiyat:',
                      style: TextStyle(
                        fontSize: 14,
                        color: context.onSurface.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '\$${(product.price ?? 0).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: context.primary,
                      ),
                    ),
                  ],
                ),
              ),
              // Stok Durumu Kısmı
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Stok Durumu:',
                    style: TextStyle(
                      fontSize: 14,
                      color: context.onSurface.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 2),
                  _buildProductStatus(product),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Sepete Ekle Butonu
          SizedBox(
            width: double.infinity,
            height: 48,
            child: GeneralButton(
              text: 'Sepete Ekle',
              onPressed: stockStatus != ProductStatusEnum.outOfStock
                  ? () => _addToCartAndNavigate(context, product)
                  : () {},
              color: stockStatus != ProductStatusEnum.outOfStock
                  ? context.primary
                  : context.onSurface.withOpacity(0.3),
              textColor: context.onPrimary,
              icon: Icons.shopping_cart_outlined,
            ),
          ),

          if (stockStatus == ProductStatusEnum.outOfStock) ...[
            const SizedBox(height: 8),
            Center(
              child: Text(
                'Bu ürün şu anda stokta yok',
                style: TextStyle(
                  fontSize: 12,
                  color: context.error,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProductStatus(product) {
    final quantity = product.stock ?? 0;
    final stockStatus = getStockStatusFromQuantity(quantity);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: stockStatus.backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Helper(
        text: stockStatus.name,
        color: stockStatus.color,
      ),
    );
  }

  void _addToCartAndNavigate(BuildContext context, product) {
    try {
      // CartModel oluştur
      final cartItem = CartModel.fromProductModel(product, quantity: 1);

      // Cart'a ekle
      final cartViewModel = Provider.of<CartViewModel>(context, listen: false);
      cartViewModel.addItem(cartItem);

      // Başarı mesajı göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product.name} sepete eklendi!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Sepeti Gör',
            textColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartView()),
              );
            },
          ),
        ),
      );

      // 1 saniye bekle ve cart sayfasına git
      Future.delayed(Duration(seconds: 1), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CartView()),
        );
      });
    } catch (e) {
      // Hata durumunda mesaj göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ürün sepete eklenirken hata oluştu: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildActionButton(BuildContext context, NFCViewModel viewModel) {
    return SizedBox(
      height: 50,
      child: GeneralButton(
        text: viewModel.isError ? 'Tekrar Dene' : 'Tekrar Tara',
        onPressed: () {
          viewModel.startNFCScan();
        },
        color: viewModel.isError ? context.error : context.secondary,
        textColor: context.onPrimary,
        icon: Icons.nfc,
      ),
    );
  }
}
