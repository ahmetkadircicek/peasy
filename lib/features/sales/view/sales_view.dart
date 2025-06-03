import 'package:flutter/material.dart';
import 'package:peasy/core/components/general_background.dart';
import 'package:peasy/core/components/general_text.dart';
import 'package:provider/provider.dart';

import '../viewmodel/sales_view_model.dart';

class SalesView extends StatelessWidget {
  const SalesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SalesViewModel()..fetchCoupons(),
      child: Stack(
        children: [
          const GeneralBackground(),
          _buildScaffold(),
        ],
      ),
    );
  }

  Widget _buildScaffold() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Highlight(text: "Kampanyalar"),
        centerTitle: true,
      ),
      body: Consumer<SalesViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(
                child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)));
          }
          if (viewModel.coupons.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_offer_outlined,
                      size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Content(
                    text: "Şu anda aktif bir kampanya yok",
                    color: Colors.grey[600],
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 24),
              itemCount: viewModel.coupons.length,
              itemBuilder: (context, index) =>
                  _buildCouponCard(context, viewModel.coupons[index]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCouponCard(BuildContext context, dynamic coupon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4)),
          BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 2,
              offset: const Offset(0, 1)),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Content(
                isBold: true,
                text: coupon.title,
                color: const Color(0xFF1D1D1F),
              )),
              const SizedBox(width: 12),
            ],
          ),
          const SizedBox(height: 12),
          Label(
            text: coupon.description,
            color: Colors.grey[700],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCouponCodeTag(context, coupon.couponCode),
              _buildDiscountTag(coupon),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDiscountTag(dynamic coupon) {
    final isPercentage = coupon.discountType == "percentage";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isPercentage
              ? [Color(0xFF34C759), Color(0xFF30B350)]
              : [Color(0xFF007AFF), Color(0xFF0056CC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: (isPercentage ? Color(0xFF34C759) : Color(0xFF007AFF))
                  .withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Helper(
        text: isPercentage
            ? "%${coupon.discountRate}"
            : "${coupon.discountRate}₺",
        color: Colors.white,
      ),
    );
  }

  Widget _buildCouponCodeTag(BuildContext context, String couponCode) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: Color(0xFFF2F2F7),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.content_copy_rounded, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Label(
            text: couponCode,
            color: Colors.grey[800],
          ),
        ],
      ),
    );
  }
}
