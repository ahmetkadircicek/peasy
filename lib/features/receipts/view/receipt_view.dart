import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/receipt_view_model.dart';

class ReceiptView extends StatelessWidget {
  const ReceiptView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReceiptViewModel()..fetchUserOrders(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Geçmiş Siparişler'),
        ),
        body: Consumer<ReceiptViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.orders.isEmpty) {
              return const Center(child: Text('Geçmiş sipariş bulunamadı.'));
            }

            return ListView.builder(
              itemCount: viewModel.orders.length,
              itemBuilder: (context, index) {
                final order = viewModel.orders[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sipariş No: ${order.orderId}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                            'Tarih: ${order.orderDate.toLocal().toString().split(".")[0]}'),
                        Text(
                            'Toplam: ₺${order.totalAmount.toStringAsFixed(2)}'),
                        const SizedBox(height: 8),
                        ...order.orderItems.map((item) => Text(
                              '${item.name} x${item.quantity} - ₺${item.price}',
                            )),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
