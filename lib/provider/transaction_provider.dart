import 'package:flutter/material.dart';

class TransactionProvider extends ChangeNotifier {
  int? bike;
  int? package;
  String? paymentMethod;

  void setBike(int bike) {
    this.bike = bike;
    notifyListeners();
  }

  void setPackage(int package) {
    this.package = package;
    notifyListeners();
  }

  void setPaymentMethod(String method) {
    paymentMethod = method;
    notifyListeners();
  }
}
