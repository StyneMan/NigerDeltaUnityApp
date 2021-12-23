import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  String? _phoneNumber;
  String? _emailAddress;
  String? _facebookPage;
  String? _instagramHandle;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('others')
        .doc("contact-us")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          _phoneNumber = documentSnapshot.get("phone");
          _emailAddress = documentSnapshot.get("email");
          _facebookPage = documentSnapshot.get("facebook");
          _instagramHandle = documentSnapshot.get("instagram");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'assets/images/handshake.jpeg',
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
                    top: 36,
                    left: 21,
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 48),
                      child: TextRoboto(
                        text: 'Contact Us',
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 36,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/blue_phone_icon.svg'),
                        const SizedBox(
                          width: 16.0,
                        ),
                        TextRoboto(
                          text: _phoneNumber ?? "",
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/blue_message_icon.svg'),
                        const SizedBox(
                          width: 16.0,
                        ),
                        TextRoboto(
                          text: _emailAddress ?? "",
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/blue_fb_icon.svg'),
                        const SizedBox(
                          width: 16.0,
                        ),
                        TextRoboto(
                          text: _facebookPage ?? "",
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/blue_insta_icon.svg'),
                        const SizedBox(
                          width: 16.0,
                        ),
                        TextRoboto(
                          text: _instagramHandle ?? "",
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
