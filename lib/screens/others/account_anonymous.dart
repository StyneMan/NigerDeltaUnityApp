import 'package:flutter/material.dart';

class AccountAnonymous extends StatelessWidget {
  const AccountAnonymous({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(21.0),
      child: const Center(
        child: ClipOval(
          child: Icon(
            Icons.account_circle_outlined,
            size: 48,
          ),
        ),
      ),
    );
  }
}
