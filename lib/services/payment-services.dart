import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;

class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({required this.message, required this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com//v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String secret =
      'sk_test_51KVK8aIfqGkw1dqiraIEiU6P32HZdlcpt8cUPHztHZ6RZWsJWcHlXLxS2We9yWaZ7nxfe3y6acLnc9W4elfnAkfm00trvCusDe';
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-type': 'application/x-www-form-urlencoded'
  };

  static init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51KVK8aIfqGkw1dqihrZXzW6vWyn5bVF8byd1RM6dpP2jAETJeVnMlFAlUh18C2To5Q2vFALN5RWAE28Xq73hSr2i00EGRdnQKL",
        merchantId: "Test",
        androidPayMode: 'test'));
  }

  static Future<StripeTransactionResponse> payViaExistingCard(
      {required String amount,
      required String currency,
      required CreditCard card}) async {
    try {
      var paymentMethod = await StripePayment.createPaymentMethod(
          PaymentMethodRequest(card: card));

      var paymentIntents =
          await StripeService.createPaymentIntent(amount, currency);

      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
        clientSecret: paymentIntents['client_secret'],
        paymentMethodId: paymentMethod.id,
      ));

      if (response.status == 'succeeded') {
        return StripeTransactionResponse(
            message: "Transaction Successful", success: true);
      } else {
        return StripeTransactionResponse(
            message: "Transaction Failed", success: false);
      }
    } on PlatformException catch (e) {
      return StripeService.getPlatformExceptionErrorResult(e);
    } catch (e) {
      return StripeTransactionResponse(
          message: "Transaction Failed: ${e.toString()}", success: false);
    }
  }

  static Future<StripeTransactionResponse> payViaNewCard(
      {required String amount, required String currency}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      var paymentIntents =
          await StripeService.createPaymentIntent(amount, currency);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
        clientSecret: paymentIntents['client_secret'],
        paymentMethodId: paymentMethod.id,
      ));
      if (response.status == 'succeeded') {
        return StripeTransactionResponse(
            message: "Transaction Successful", success: true);
      } else {
        return StripeTransactionResponse(
            message: "Transaction Failed", success: false);
      }
    } on PlatformException catch (e) {
      return StripeService.getPlatformExceptionErrorResult(e);
    }
  }

  static getPlatformExceptionErrorResult(e) {
    String message = "Something went wrong";
    if (e.code == 'cancelled') message = 'Transaction cancelled';

    return StripeTransactionResponse(message: message, success: false);
  }

  static createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(Uri.parse(StripeService.paymentApiUrl),
          body: body, headers: StripeService.headers);
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
    }
    return null;
  }
}
