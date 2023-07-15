import 'dart:math';

import 'package:faker/faker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Utils {
  Utils._();

  static String getGuid() {
    const uuid = Uuid();
    return uuid.v4();
  }

  static String getNairaCurrencyFormat(double amount) {
    final formattedAmount = getCurrencyFormat(amount);
    return '\u{20A6}$formattedAmount';
  }

  static String getUSDCurrencyFormat(double amount) {
    final formattedAmount = getCurrencyFormat(amount);
    return '\$$formattedAmount';
  }

  static String getCurrencyFormat(double amount, {int decimalDigits = 2}) {
    final NumberFormat formatter = NumberFormat.currency(
      symbol: '',
      decimalDigits: decimalDigits,
    );
    return formatter.format(amount);
  }

  static String getNumberFromFormattedAmount(String s) {
    return NumberFormat.currency().parse(s).toInt().toString();
  }

  static String formatNumber(int number) {
    if (number >= 1000) {
      double num = number / 1000.0;
      String formattedNumber = num.toStringAsFixed(1);
      return '${formattedNumber}k';
    } else {
      return number.toString();
    }
  }
}

final Faker faker = Faker();

final Random random = Random();

Future<void> fakeNetworkDelay({int seconds = 2}) async {
  await Future.delayed(Duration(seconds: seconds));
}
