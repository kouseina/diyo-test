import 'package:flutter/material.dart';

enum TableStatus {
  available,
  seated,
  ordered,
  billing,
}

extension TableColor on TableStatus {
  Color getBgColor() {
    switch (index) {
      case 0:
        return Colors.white;
      case 1:
        return Colors.red;
      case 2:
        return Colors.yellow;
      case 3:
        return Colors.blue;
      default:
        return Colors.white;
    }
  }

  Color getTextColor() {
    switch (index) {
      case 0:
        return Colors.red;
      default:
        return Colors.white;
    }
  }
}

enum PaymentMethod {
  cash,
  creditCard,
  debitCard,
  qris,
}

extension PaymentMethodTitle on PaymentMethod {
  String getTitle() {
    switch (index) {
      case 0:
        return "Cash";
      case 1:
        return "Credit Card";
      case 2:
        return "Debit Card";
      case 3:
        return "QRIS";
      default:
        return "";
    }
  }
}
