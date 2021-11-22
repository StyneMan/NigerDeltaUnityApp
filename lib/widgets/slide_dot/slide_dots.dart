import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';

class SlideDots extends StatelessWidget {
  final bool isActive;
  SlideDots({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      height: isActive ? 12.0 : 8.0,
      width: isActive ? 12.0 : 8.0,
      decoration: BoxDecoration(
        color: Constants.primaryColor,
        border: Border.all(
          color: Colors.white,
          width: 2.0,
          style: BorderStyle.solid,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
    );
  }
}
