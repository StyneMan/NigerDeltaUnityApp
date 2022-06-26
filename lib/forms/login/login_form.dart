import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:niger_delta_unity_app/screens/dashboard/dashboard.dart';
import 'package:niger_delta_unity_app/screens/others/account_suspended.dart';
import 'package:niger_delta_unity_app/screens/password/password_reset.dart';
import 'package:niger_delta_unity_app/screens/signup/signup.dart';
import 'package:niger_delta_unity_app/state/state_manager.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';
import 'package:niger_delta_unity_app/utility/preference_manager.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isRememberChecked = false;
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final _controller = Get.find<StateManager>();
  PreferenceManager? _prefManager;


  _togglePass() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  initAuth() async {
    final prefs = await SharedPreferences.getInstance();
    bool _shouldRem = prefs.getBool("remember") ?? false;
    String _email = prefs.getString("email") ?? "";
    String _pass = prefs.getString("password") ?? "";

    if (_shouldRem) {
      _emailController.text = _email;
      _passwordController.text = _pass;
    }
  }

  @override
  void initState() {
    super.initState();
    initAuth();
    _prefManager = PreferenceManager(context);
  }

  _login() async {
    _controller.setIsLoading(true);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
      //Now retrieve user data and check if user is blocked
      if (userCredential.user != null) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            // Now save to shared preference
            if (documentSnapshot.get("isBlocked") == true) {
              //user is blocked by super admin
              _controller.setIsLoading(false);
              Fluttertoast.showToast(
                msg: 'Account is suspended',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 4,
                backgroundColor: Colors.grey[800],
                textColor: Colors.white,
                fontSize: 16.0,
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountSuspended(),
                ),
              );
            } else {
              _prefManager!.setIsLoggedIn(true);
              _prefManager!.setUserData(documentSnapshot.data().toString());
              if (_isRememberChecked) {
                _prefManager!.setRememberMe(_emailController.text, _passwordController.text, true);
              }
              else {
                _prefManager!.setRememberMe("", "", false);
              }

              _controller.setIsLoading(false);
              Fluttertoast.showToast(
                msg: 'Logged in successfully',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.grey[800],
                textColor: Colors.white,
                fontSize: 16.0,
              );
              //Now route to dashboard
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Dashboard(
                    prefManager: _prefManager!,
                  ),
                ),
              );
            }
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      _controller.setIsLoading(false);
      Fluttertoast.showToast(
          msg: "" + e.message!,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
          fontSize: 16.0);
      // if (e.code == 'user-not-found') {
      //   print('No user found for that email.');
      // } else if (e.code == 'wrong-password') {
      //   print('Wrong password provided for that user.');
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Login to Continue',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Constants.primaryColor,
                fontSize: 21,
              ),
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              filled: true,
              labelText: 'Email',
              hintText: 'Email',
              labelStyle: TextStyle(
                color: Constants.primaryColor,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]')
                  .hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              labelText: 'Password',
              hintText: 'Password',
              suffixIcon: IconButton(
                onPressed: () => _togglePass(),
                icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please type password';
              }
              return null;
            },
            obscureText: _obscureText,
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Checkbox(
                    value: _isRememberChecked,
                    onChanged: (val) {
                      setState(() {
                        _isRememberChecked = val as bool;
                      });
                    },
                    checkColor: Colors.white,
                    activeColor: Constants.primaryColor,
                    focusColor: Constants.primaryColor,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  const Text(
                    'Remember me',
                    style: TextStyle(
                      color: Constants.primaryColor,
                    ),
                  )
                ],
              ),
              TextButton(
                onPressed: () {
                  Get.to(const PasswordReset());
                },
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: Constants.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Constants.primaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            child: TextButton(
              child: const Text(
                'Log in',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _login();
                }
              },
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  primary: Constants.primaryColor),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          const Text(
            'Don\'t have an account?',
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: () {
               Get.to(const Signup());
            },
            child: const Text('Signup'),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(6.0),
            ),
          ),
        ],
      ),
    );
  }
}
