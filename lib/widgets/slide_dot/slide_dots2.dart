import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';

class SlideDots2 extends StatelessWidget {
  final bool isActive;
  const SlideDots2({Key? key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      height: 14.0,
      width: 14.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : const Color(0x8AFFFFFF),
        border: Border.all(
          color: Colors.white,
          width: 2.0,
          style: BorderStyle.solid,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(7.0),
        ),
      ),
    );
  }
}
