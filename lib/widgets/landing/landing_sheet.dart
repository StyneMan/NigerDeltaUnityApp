import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:niger_delta_unity_app/screens/dashboard/dashboard.dart';
import 'package:niger_delta_unity_app/screens/login/login.dart';
import 'package:niger_delta_unity_app/screens/privacypolicy/privacy_policy.dart';
import 'package:niger_delta_unity_app/screens/signup/signup.dart';
import 'package:niger_delta_unity_app/screens/termsofservice/terms_of_service.dart';

class LandingSheet extends StatelessWidget {
  const LandingSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              },
              child: const Text(
                'Login to continue',
                textAlign: TextAlign.center,
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Signup(),
                  ),
                );
              },
              child: const Text(
                'Sign up to continue',
                textAlign: TextAlign.center,
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Dashboard(),
                  ),
                );
              },
              child: const Text(
                'Continue as guest',
                textAlign: TextAlign.center,
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "By using NDUA, you agree to our ",
              style: const TextStyle(
                color: Colors.white,
              ),
              children: [
                TextSpan(
                  text: "Terms of Use",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async => await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TermsOfService(),
                          ),
                        ),
                ),
                TextSpan(
                  text: " Privacy Policy",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async => await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrivacyPolicy(),
                          ),
                        ),
                ),
                const TextSpan(
                  text: " and to receive offers and updates ",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
