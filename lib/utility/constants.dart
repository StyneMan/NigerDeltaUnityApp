import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:money_formatter/money_formatter.dart';
import "package:intl/intl.dart";
// import 'package:maps_launcher/maps_launcher.dart';

class Constants {
  static const Color primaryColor = Color(0xFF0C0C77);
  static const Color accentColor = Color(0xFF0094FF);
  static const Color secondaryColor = Color(0xFFF25E22);

  static Future<void> makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  } 

  static Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
  
  // static launchMap(String value) {
  //   MapsLauncher.launchQuery(value);
  // }

  static String formatMoney(String amt) {
    MoneyFormatter fmf =  MoneyFormatter(
    amount: double.parse("${amt}.00"),
    settings: MoneyFormatterSettings(
        symbol: 'NGN',
        thousandSeparator: ',',
        decimalSeparator: '.',
        symbolAndNumberSeparator: ' ',
        fractionDigits: 3,
        compactFormatType: CompactFormatType.short
      )
    );
    return fmf.output.withoutFractionDigits;
  }

  static nairaSign(context) {
    Locale locale = Localizations.localeOf(context);
    var format = NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
    return format;
  }

}
