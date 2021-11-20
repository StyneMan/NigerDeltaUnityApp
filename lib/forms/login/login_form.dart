import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:niger_delta_unity_app/screens/password/password_reset.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';

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

  _togglePass() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
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
                onPressed: () {},
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
              onPressed: () {},
              child: const Text('Signup'),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(6.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
