import 'package:flutter/material.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';

class Personal extends StatelessWidget {
  const Personal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextRoboto(
                text: 'Full Name',
                fontSize: 11,
                color: const Color(0xFF030928),
                fontWeight: FontWeight.w500,
              ),
              TextInter(
                text: 'Obinna Gregg',
                fontSize: 11,
                color: const Color(0xFFC4C4C4),
                fontWeight: FontWeight.w500,
              )
            ],
          ),
        ),
        const Divider(
          thickness: 1.0,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextRoboto(
                text: 'Email',
                fontSize: 11,
                color: const Color(0xFF030928),
                fontWeight: FontWeight.w500,
              ),
              TextInter(
                text: 'testuser@gmail.com',
                fontSize: 11,
                color: const Color(0xFFC4C4C4),
                fontWeight: FontWeight.w500,
              )
            ],
          ),
        ),
        const Divider(
          thickness: 1.0,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextRoboto(
                text: 'Phone',
                fontSize: 11,
                color: const Color(0xFF030928),
                fontWeight: FontWeight.w500,
              ),
              TextInter(
                text: '+2348162680095',
                fontSize: 11,
                color: const Color(0xFFC4C4C4),
                fontWeight: FontWeight.w500,
              )
            ],
          ),
        ),
        const Divider(
          thickness: 1.0,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextRoboto(
                text: 'Gender',
                fontSize: 11,
                color: const Color(0xFF030928),
                fontWeight: FontWeight.w500,
              ),
              TextInter(
                text: 'Male',
                fontSize: 11,
                color: const Color(0xFFC4C4C4),
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
