import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

import '../model/payment_model.dart';

class PaymentViewModel extends ChangeNotifier {
  PaymentModel? _paymentData;
  PaymentModel? get paymentData => _paymentData;

  final bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isProcessingPayment = false;
  bool get isProcessingPayment => _isProcessingPayment;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Callback for clearing cart after successful payment
  VoidCallback? _onPaymentSuccess;

  // Pay package configurations
  final List<PaymentItem> _paymentItems = [];
  Pay? _payClient;

  List<PaymentMethod> get availablePaymentMethods {
    final methods = <PaymentMethod>[];

    // Google Pay is now available for all platforms for demo purposes
    methods.add(PaymentMethod.googlePay);

    if (Platform.isIOS) {
      methods.add(PaymentMethod.applePay);
    }

    if (Platform.isAndroid) {
      // Google Pay already added above for better visibility
    }

    methods.add(PaymentMethod.creditCard);

    return methods;
  }

  // Set callback for successful payment (used for cart clearing)
  void setPaymentSuccessCallback(VoidCallback? callback) {
    _onPaymentSuccess = callback;
  }

  Future<void> initializePayment({
    required List<OrderItem> items,
    String? couponCode,
    VoidCallback? onPaymentSuccess,
  }) async {
    _onPaymentSuccess = onPaymentSuccess;

    final subtotal = items.fold<double>(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    final tax = subtotal * 0.18; // %18 KDV
    final discount = couponCode != null ? subtotal * 0.10 : 0.0; // %10 indirim
    final total = subtotal + tax - discount;

    _paymentData = PaymentModel(
      orderId: _generateOrderId(),
      subtotal: subtotal,
      tax: tax,
      discount: discount,
      total: total,
      items: items,
    );

    // Initialize payment items for Pay package
    _paymentItems.clear();
    for (final item in items) {
      _paymentItems.add(
        PaymentItem(
          label: item.name,
          amount: (item.price * item.quantity).toStringAsFixed(2),
          status: PaymentItemStatus.final_price,
        ),
      );
    }

    if (tax > 0) {
      _paymentItems.add(
        PaymentItem(
          label: 'KDV (%18)',
          amount: tax.toStringAsFixed(2),
          status: PaymentItemStatus.final_price,
        ),
      );
    }

    if (discount > 0) {
      _paymentItems.add(
        PaymentItem(
          label: 'İndirim',
          amount: '-${discount.toStringAsFixed(2)}',
          status: PaymentItemStatus.final_price,
        ),
      );
    }

    _paymentItems.add(
      PaymentItem(
        label: 'Toplam',
        amount: total.toStringAsFixed(2),
        status: PaymentItemStatus.final_price,
      ),
    );

    // Initialize Pay client with configurations
    await _initializePayClient();

    notifyListeners();
  }

  Future<void> _initializePayClient() async {
    try {
      final Map<PayProvider, PaymentConfiguration> configurations = {};

      if (Platform.isIOS) {
        final applePayConfig = await PaymentConfiguration.fromAsset(
            'assets/payment/apple_pay_config.json');
        configurations[PayProvider.apple_pay] = applePayConfig;
      }

      if (Platform.isAndroid) {
        final googlePayConfig = await PaymentConfiguration.fromAsset(
            'assets/payment/google_pay_config.json');
        configurations[PayProvider.google_pay] = googlePayConfig;
      }

      _payClient = Pay(configurations);
    } catch (e) {
      debugPrint("Error initializing Pay client: $e");
    }
  }

  void selectPaymentMethod(PaymentMethod method) {
    if (_paymentData != null) {
      _paymentData = _paymentData!.copyWith(selectedPaymentMethod: method);
      notifyListeners();
    }
  }

  Future<bool> processPayment() async {
    if (_paymentData?.selectedPaymentMethod == null) {
      _errorMessage = "Lütfen bir ödeme yöntemi seçin";
      notifyListeners();
      return false;
    }

    if (_payClient == null) {
      _errorMessage = "Ödeme sistemi henüz hazır değil";
      notifyListeners();
      return false;
    }

    _isProcessingPayment = true;
    _errorMessage = null;
    notifyListeners();

    try {
      bool paymentSuccess = false;

      switch (_paymentData!.selectedPaymentMethod!) {
        case PaymentMethod.applePay:
          paymentSuccess = await _processApplePay();
          break;
        case PaymentMethod.googlePay:
          paymentSuccess = await _processGooglePay();
          break;
        case PaymentMethod.creditCard:
          paymentSuccess = await _processCreditCard();
          break;
      }

      // If payment was successful, trigger cart clearing
      if (paymentSuccess && _onPaymentSuccess != null) {
        _onPaymentSuccess!();
        debugPrint("Cart cleared after successful payment");
      }

      return paymentSuccess;
    } catch (e) {
      _errorMessage = "Ödeme işlemi sırasında bir hata oluştu: $e";
      return false;
    } finally {
      _isProcessingPayment = false;
      notifyListeners();
    }
  }

  Future<bool> _processApplePay() async {
    try {
      if (Platform.isIOS && _payClient != null) {
        final result = await _payClient!.showPaymentSelector(
          PayProvider.apple_pay,
          _paymentItems,
        );

        debugPrint("Apple Pay payment successful: $result");
        return true;
      }

      return false;
    } catch (e) {
      debugPrint("Apple Pay error: $e");
      _errorMessage = "Apple Pay ödeme hatası: $e";
      return false;
    }
  }

  Future<bool> _processGooglePay() async {
    try {
      if (Platform.isAndroid && _payClient != null) {
        final result = await _payClient!.showPaymentSelector(
          PayProvider.google_pay,
          _paymentItems,
        );

        debugPrint("Google Pay payment successful: $result");
        return true;
      }

      return false;
    } catch (e) {
      debugPrint("Google Pay error: $e");
      _errorMessage = "Google Pay ödeme hatası: $e";
      return false;
    }
  }

  Future<bool> _processCreditCard() async {
    // Credit card processing would go here
    // This could integrate with Stripe, PayPal, or other payment processors
    try {
      // Simulate credit card processing
      await Future.delayed(const Duration(seconds: 2));
      debugPrint("Processing Credit Card payment for ${_paymentData!.total}₺");
      return true;
    } catch (e) {
      _errorMessage = "Kredi kartı ödeme hatası: $e";
      return false;
    }
  }

  String _generateOrderId() {
    return 'ORDER_${DateTime.now().millisecondsSinceEpoch}';
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Check if payment method is available
  Future<bool> isPaymentMethodAvailable(PaymentMethod method) async {
    try {
      if (_payClient == null) return false;

      switch (method) {
        case PaymentMethod.applePay:
          if (Platform.isIOS) {
            return await _payClient!.userCanPay(PayProvider.apple_pay);
          }
          return false;
        case PaymentMethod.googlePay:
          if (Platform.isAndroid) {
            return await _payClient!.userCanPay(PayProvider.google_pay);
          }
          return false;
        case PaymentMethod.creditCard:
          return true; // Credit card is always available
      }
    } catch (e) {
      debugPrint("Error checking payment method availability: $e");
      return false;
    }
  }
}
