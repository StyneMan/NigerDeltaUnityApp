import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:niger_delta_unity_app/screens/contact/contact_us.dart';
import 'package:niger_delta_unity_app/widgets/landing/landing_sheet.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/bgImage.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                color: const Color(0x750C0C77),
              ),
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.to(const ContactUs());
                              },
                              child: const Text(
                                'Contact Us',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 16.0,
                            ),
                            Image.asset('assets/images/logo_white.png'),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Text(
                              'Welcome To NDUA!',
                              style: TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                              ),
                            ),
                            //Bottom Sheet Here
                            const Expanded(
                              child: LandingSheet(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                top: 10,
                bottom: 10,
                left: 10,
                right: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
