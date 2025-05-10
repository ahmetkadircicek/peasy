import 'package:flutter/material.dart';
import 'package:peasy/core/components/general_app_bar.dart';
import 'package:peasy/core/components/general_background.dart';
import 'package:peasy/core/components/general_button.dart';
import 'package:peasy/core/components/general_text.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/extensions/context_extension.dart';
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
            return Center(
              child: Padding(
                padding: PaddingConstants.pagePadding,
                child: Column(
                  spacing: 32,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    _buildScannerAnimation(context, viewModel),
                    _buildStatusText(viewModel),
                    if (viewModel.isError) _buildErrorMessage(viewModel),
                    if (viewModel.product != null) _buildProductInfo(viewModel),
                    Spacer(),
                    _buildActionButton(context, viewModel),
                  ],
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: PaddingConstants.allMedium,
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Content(text: product.name ?? '', isBold: true),
          Divider(),
          Row(
            children: [
              Expanded(
                child: Label(text: 'Price:'),
              ),
              Helper(text: '\$${product.price}'),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Label(text: 'Status:'),
              ),
              _buildProductStatus(product),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductStatus(product) {
    final isInStock = product.stockStatus.toString().contains('inStock');
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isInStock ? Colors.green.shade100 : Colors.red.shade100,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Helper(
        text: isInStock ? 'In Stock' : 'Out of Stock',
        color: isInStock ? Colors.green.shade800 : Colors.red.shade800,
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, NFCViewModel viewModel) {
    if (viewModel.product != null) {
      return SizedBox(
        height: 50,
        child: GeneralButton(
          text: 'Continue',
          onPressed: () {
            Navigator.of(context).pop(viewModel.product);
          },
          color: context.primary,
          textColor: context.onPrimary,
        ),
      );
    }
    return SizedBox(
      height: 50,
      child: GeneralButton(
        text: viewModel.isError ? 'Try Again' : 'Scan',
        onPressed: () {
          viewModel.startNFCScan();
        },
        color: viewModel.isError ? context.primary : context.error,
        textColor: context.onPrimary,
        icon: Icons.nfc,
      ),
    );
  }
}
