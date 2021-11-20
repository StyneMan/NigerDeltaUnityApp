import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:niger_delta_unity_app/screens/login/login.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
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
        child: SizedBox(
          width: double.infinity,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Signup to continue',
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
                  labelText: 'First Name',
                  hintText: 'First Name',
                  labelStyle: TextStyle(
                    color: Constants.primaryColor,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.name,
                controller: _firstnameController,
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Last Name',
                  hintText: 'Last Name',
                  labelStyle: TextStyle(
                    color: Constants.primaryColor,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.name,
                controller: _lastnameController,
              ),
              const SizedBox(
                height: 8.0,
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
                height: 12.0,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Constants.primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                child: TextButton(
                  child: const Text(
                    'Signup',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {},
                  style:
                      TextButton.styleFrom(padding: const EdgeInsets.all(16.0)),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Already have an account?',
                textAlign: TextAlign.center,
              ),
              TextButton(
                onPressed: () {
                  Get.to(const Login());
                },
                child: const Text('Login'),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(8.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
