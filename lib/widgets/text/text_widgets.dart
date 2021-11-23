import 'package:flutter/material.dart';

class TextAriel extends StatelessWidget {
  late final String? text;
  late final double? fontSize;
  late final Color? color;
  late final TextAlign? align;
  late final FontWeight? fontWeight;
  late final bool? softWrap;

  TextAriel(
      {required this.text,
      this.color,
      required this.fontSize,
      this.fontWeight,
      this.align,
      this.softWrap});

  final fontFamily = "Market";

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      softWrap: softWrap,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      ),
    );
  }
}

class TextRoboto extends StatelessWidget {
  late final String? text;
  late final double? fontSize;
  late final Color? color;
  late final FontWeight? fontWeight;
  late final TextAlign? align;

  TextRoboto(
      {required this.text,
      this.color,
      required this.fontSize,
      this.fontWeight,
      this.align});

  final fontFamily = "Roboto";

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      ),
    );
  }
}

class TextRopa extends StatelessWidget {
  late final String? text;
  late final double? fontSize;
  late final Color? color;
  late final FontWeight? fontWeight;
  late final TextAlign? align;

  TextRopa(
      {required this.text,
      this.color,
      required this.fontSize,
      this.fontWeight,
      this.align});

  final fontFamily = "Roboto";

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      ),
    );
  }
}

class TextGeorgia extends StatelessWidget {
  late final String? text;
  late final double? fontSize;
  late final Color? color;
  late final FontWeight? fontWeight;
  late final TextAlign? align;

  TextGeorgia(
      {required this.text,
      this.color,
      required this.fontSize,
      this.fontWeight,
      this.align});

  final fontFamily = "Roboto";

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      ),
    );
  }
}

class TextInter extends StatelessWidget {
  late final String? text;
  late final double? fontSize;
  late final Color? color;
  late final FontWeight? fontWeight;
  late final TextAlign? align;

  TextInter(
      {required this.text,
      this.color,
      required this.fontSize,
      this.fontWeight,
      this.align});

  final fontFamily = "Roboto";

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      ),
    );
  }
}
