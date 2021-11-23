import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

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
                    top: 48,
                    left: 24,
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
                          text: '+234 816 2680 095',
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
                          text: 'info@ndua.com',
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
                          text: 'www.facebook.com/ndua',
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
                          text: 'www.instagram.com/ndua',
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
