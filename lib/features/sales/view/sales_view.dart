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
        title: Highlight(text: "Kampanyalar"),
      ),
      body: Consumer<SalesViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.coupons.isEmpty) {
            return const Center(child: Text("Şu anda aktif bir kampanya yok."));
          }

          return ListView.builder(
            itemCount: viewModel.coupons.length,
            itemBuilder: (context, index) {
              final coupon = viewModel.coupons[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Headline(text: coupon.title),
                      SubHeadline(
                        text: coupon.description,
                        fontSize: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Helper(
                            text: "Kod: ${coupon.couponCode}",
                            isBold: true,
                            color: Theme.of(context).primaryColor,
                          ),
                          Helper(
                            text: coupon.discountType == "percentage"
                                ? "%${coupon.discountRate} ${coupon.discountType}"
                                : "${coupon.discountRate}₺ ${coupon.discountType}",
                            isBold: true,
                            color: Color(Colors.green.shade800.value),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
