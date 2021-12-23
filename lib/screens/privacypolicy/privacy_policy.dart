import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';

class PrivacyPolicy extends StatefulWidget {
  PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  String? _body;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('others')
        .doc("privacy-policy")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          _body = documentSnapshot.get("body");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: MediaQuery.of(context).size.height * 0.33,
      //   elevation: 0,

      //   automaticallyImplyLeading: false,
      //   shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //       bottomLeft: Radius.circular(24.0),
      //       bottomRight: Radius.circular(24.0),
      //     ),
      //   ),
      // ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.33,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset(
                    'assets/images/privacy.jpeg',
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.noRepeat,
                    height: MediaQuery.of(context).size.height * 0.33,
                    width: double.infinity,
                  ),
                  Container(
                    color: const Color(0xA60C0C77),
                    height: MediaQuery.of(context).size.height * 0.33,
                    width: double.infinity,
                  ),
                  Positioned(
                    child: ClipOval(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset(
                          'assets/images/back_circular.svg',
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ),
                    top: 48,
                    left: 24,
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 48),
                      child: TextRoboto(
                        text: 'Privacy policy',
                        fontSize: 24,
                        align: TextAlign.center,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextRoboto(
                text: _body ?? "",
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.w400,
                align: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
