import 'package:flutter/material.dart';
import 'package:peasy/core/components/general_background.dart';
import 'package:peasy/core/components/general_text.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:provider/provider.dart';

import '../model/payment_model.dart';
import '../viewmodel/payment_view_model.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    // This is now only used as a fallback, main usage is through PaymentViewWrapper
    return Center(
      child: Helper(
        text: "Lütfen sepet sayfasından ödeme işlemini başlatın.",
        isCentred: true,
        color: context.onSurface.withOpacity(0.7),
      ),
    );
  }
}

class PaymentViewWrapper extends StatelessWidget {
  final List<OrderItem> orderItems;
  final VoidCallback? onPaymentSuccess;

  const PaymentViewWrapper({
    super.key,
    required this.orderItems,
    this.onPaymentSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final viewModel = PaymentViewModel();
        viewModel.initializePayment(
          items: orderItems,
          onPaymentSuccess: onPaymentSuccess,
        );
        return viewModel;
      },
      child: Stack(
        children: [
          const GeneralBackground(),
          _buildScaffold(context),
        ],
      ),
    );
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Highlight(
          text: "Ödeme",
          color: context.primary,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20, color: context.primary),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Consumer<PaymentViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.paymentData == null) {
            return Center(
              child: CircularProgressIndicator(color: context.primary),
            );
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      _buildOrderSummary(context, viewModel.paymentData!),
                      const SizedBox(height: 24),
                      _buildPaymentMethods(context, viewModel),
                      const SizedBox(height: 24),
                      _buildPricingDetails(context, viewModel.paymentData!),
                      const SizedBox(height: 120), // Space for bottom button
                    ],
                  ),
                ),
              ),
              _buildBottomPaymentButton(context, viewModel),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context, PaymentModel paymentData) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.95),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: context.primary.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: context.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    size: 20,
                    color: context.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Content(
                  text: "Sipariş Özeti",
                  color: context.primary,
                  isBold: true,
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...paymentData.items.map((item) => _buildOrderItem(context, item)),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(BuildContext context, OrderItem item) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.tertiary.withOpacity(0.3),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Helper(
                  text: item.name,
                  color: context.onSurface,
                  isBold: true,
                  overflow: true,
                  maxLines: 1,
                ),
                const SizedBox(height: 2),
                Label(
                  text: "x${item.quantity}",
                  color: context.secondary,
                ),
              ],
            ),
          ),
          Helper(
            text: "${(item.price * item.quantity).toStringAsFixed(0)}₺",
            color: context.primary,
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods(
      BuildContext context, PaymentViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.95),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: context.primary.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: context.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.payment_outlined,
                    size: 20,
                    color: context.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Content(
                  text: "Ödeme Yöntemi",
                  color: context.primary,
                  isBold: true,
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Google Pay promotion banner
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF4285F4).withOpacity(0.1),
                    const Color(0xFF34A853).withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF4285F4).withOpacity(0.2),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: const Color(0xFF4285F4),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Label(
                      text: "Google Pay ile hızlı ve güvenli ödeme yapın",
                      color: const Color(0xFF4285F4),
                      isBold: true,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ...viewModel.availablePaymentMethods.map(
              (method) => _buildPaymentMethodTile(context, method, viewModel),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodTile(
      BuildContext context, PaymentMethod method, PaymentViewModel viewModel) {
    final isSelected = viewModel.paymentData?.selectedPaymentMethod == method;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => viewModel.selectPaymentMethod(method),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(
                        colors: [
                          context.primary.withOpacity(0.1),
                          context.primary.withOpacity(0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : LinearGradient(
                        colors: [
                          context.tertiary.withOpacity(0.5),
                          context.tertiary.withOpacity(0.3),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? context.primary : Colors.transparent,
                  width: 2,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: context.primary.withOpacity(0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                children: [
                  _buildPaymentMethodIcon(context, method),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Helper(
                          text: method.displayName,
                          color:
                              isSelected ? context.primary : context.onSurface,
                          isBold: isSelected,
                        ),
                        if (method == PaymentMethod.googlePay)
                          Label(
                            text: "Hızlı, güvenli ve kolay",
                            color: const Color(0xFF4285F4),
                          ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: context.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: context.onPrimary,
                        size: 16,
                      ),
                    ),
                ],
              ),
            ),
          ),
          // Special Google Pay benefits when selected
          if (isSelected && method == PaymentMethod.googlePay)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF4285F4).withOpacity(0.05),
                    const Color(0xFF34A853).withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF4285F4).withOpacity(0.1),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.security,
                        color: const Color(0xFF34A853),
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Label(
                          text: "Kart bilgileriniz Google tarafından korunur",
                          color: const Color(0xFF34A853),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.flash_on,
                        color: const Color(0xFFFBBC05),
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Label(
                          text: "Tek dokunuşla hızlı ödeme",
                          color: const Color(0xFFFBBC05).withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodIcon(BuildContext context, PaymentMethod method) {
    IconData iconData;
    Color iconColor;
    Color backgroundColor;

    switch (method) {
      case PaymentMethod.applePay:
        iconData = Icons.apple;
        iconColor = Colors.black;
        backgroundColor = Colors.white;
        break;
      case PaymentMethod.googlePay:
        iconData = Icons.payment;
        iconColor = Colors.white;
        backgroundColor = const Color(0xFF4285F4);
        break;
      case PaymentMethod.creditCard:
        iconData = Icons.credit_card;
        iconColor = context.primary;
        backgroundColor = Colors.white;
        break;
    }

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        gradient: method == PaymentMethod.googlePay
            ? LinearGradient(
                colors: [
                  const Color(0xFF4285F4),
                  const Color(0xFF34A853),
                  const Color(0xFFFBBC05),
                  const Color(0xFFEA4335),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : LinearGradient(
                colors: [
                  backgroundColor,
                  backgroundColor.withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: method == PaymentMethod.googlePay
              ? Colors.transparent
              : context.primary.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: method == PaymentMethod.googlePay
                ? const Color(0xFF4285F4).withOpacity(0.3)
                : Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: method == PaymentMethod.googlePay
          ? Stack(
              children: [
                Center(
                  child: Icon(
                    Icons.payment,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        'G',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF4285F4),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Icon(
              iconData,
              color: iconColor,
              size: 24,
            ),
    );
  }

  Widget _buildPricingDetails(BuildContext context, PaymentModel paymentData) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.95),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: context.primary.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: context.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.receipt_outlined,
                    size: 20,
                    color: context.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Content(
                  text: "Fiyat Detayları",
                  color: context.primary,
                  isBold: true,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildPriceRow(context, "Ara Toplam", paymentData.subtotal),
            const SizedBox(height: 12),
            _buildPriceRow(context, "KDV (%18)", paymentData.tax),
            if (paymentData.discount > 0) ...[
              const SizedBox(height: 12),
              _buildPriceRow(context, "İndirim", -paymentData.discount,
                  isDiscount: true),
            ],
            const SizedBox(height: 16),
            Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    context.primary.withOpacity(0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    context.primary.withOpacity(0.1),
                    context.primary.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: _buildPriceRow(
                context,
                "Toplam",
                paymentData.total,
                isTotal: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(BuildContext context, String label, double amount,
      {bool isTotal = false, bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isTotal
            ? Content(
                text: label,
                color: context.primary,
                isBold: true,
              )
            : Helper(
                text: label,
                color: context.secondary,
                isBold: isDiscount,
              ),
        isTotal
            ? Content(
                text: "${amount.abs().toStringAsFixed(0)}₺",
                color: context.primary,
                isBold: true,
              )
            : Helper(
                text: "${amount.abs().toStringAsFixed(0)}₺",
                color: isDiscount
                    ? const Color(0xFF34C759)
                    : isTotal
                        ? context.primary
                        : context.secondary,
                isBold: isTotal || isDiscount,
              ),
      ],
    );
  }

  Widget _buildBottomPaymentButton(
      BuildContext context, PaymentViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.95),
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: context.primary.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: viewModel.isProcessingPayment ||
                        viewModel.paymentData?.selectedPaymentMethod == null
                    ? [
                        context.secondary.withOpacity(0.5),
                        context.secondary.withOpacity(0.3),
                      ]
                    : [
                        context.primary,
                        context.primary.withOpacity(0.8),
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: viewModel.isProcessingPayment ||
                      viewModel.paymentData?.selectedPaymentMethod == null
                  ? []
                  : [
                      BoxShadow(
                        color: context.primary.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
            ),
            child: ElevatedButton(
              onPressed: viewModel.isProcessingPayment ||
                      viewModel.paymentData?.selectedPaymentMethod == null
                  ? null
                  : () => _handlePayment(context, viewModel),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                elevation: 0,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: viewModel.isProcessingPayment
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Helper(
                      text: viewModel.paymentData?.selectedPaymentMethod != null
                          ? "${viewModel.paymentData!.total.toStringAsFixed(0)}₺ Öde"
                          : "Ödeme Yöntemi Seçin",
                      color: Colors.white,
                      isBold: true,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handlePayment(
      BuildContext context, PaymentViewModel viewModel) async {
    final success = await viewModel.processPayment();

    if (success) {
      _showSuccessDialog(context);
    } else if (viewModel.errorMessage != null) {
      _showErrorSnackBar(context, viewModel.errorMessage!);
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.white.withOpacity(0.95),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF34C759),
                      const Color(0xFF30B350),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF34C759).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),
              SubHeadline(
                text: "Ödeme Başarılı!",
                color: context.primary,
                isCentred: true,
              ),
              const SizedBox(height: 12),
              Helper(
                text: "Ödemeniz başarıyla tamamlandı.\nSepetiniz temizlendi.",
                isCentred: true,
                color: context.secondary,
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      context.primary,
                      context.primary.withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                    Navigator.of(context).pop(); // Go back to cart/main screen
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Helper(
                    text: "Tamam",
                    color: Colors.white,
                    isBold: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Helper(
          text: message,
          color: Colors.white,
        ),
        backgroundColor: context.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
