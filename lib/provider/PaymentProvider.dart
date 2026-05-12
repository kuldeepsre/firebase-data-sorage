import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentProvider extends ChangeNotifier {
  late Razorpay _razorpay;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String paymentStatus = "";

  PaymentProvider() {
    _initializeRazorpay();
  }

  void _initializeRazorpay() {
    _razorpay = Razorpay();

    _razorpay.on(
      Razorpay.EVENT_PAYMENT_SUCCESS,
      _handlePaymentSuccess,
    );

    _razorpay.on(
      Razorpay.EVENT_PAYMENT_ERROR,
      _handlePaymentError,
    );

    _razorpay.on(
      Razorpay.EVENT_EXTERNAL_WALLET,
      _handleExternalWallet,
    );
  }

  void startPayment({
    required String amount,
    required String name,
    required String description,
    required String contact,
    required String email,
  }) {
    _isLoading = true;
    notifyListeners();

    var options = {
      'key': 'rzp_test_GG88Yfs560mHjB',
      'amount': (double.parse(amount) * 100).toInt(),
      'name': name,
      'description': description,
      'prefill': {
        'contact': contact,
        'email': email,
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      paymentStatus = e.toString();
      notifyListeners();
    }
  }

  void _handlePaymentSuccess(
      PaymentSuccessResponse response) {
    paymentStatus =
    "Payment Success\nPayment ID: ${response.paymentId}";

    notifyListeners();
  }

  void _handlePaymentError(
      PaymentFailureResponse response) {
    paymentStatus =
    "Payment Failed\n${response.message}";

    notifyListeners();
  }

  void _handleExternalWallet(
      ExternalWalletResponse response) {
    paymentStatus =
    "External Wallet: ${response.walletName}";

    notifyListeners();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}