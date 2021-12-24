import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';

class Security extends StatefulWidget {
  const Security({Key? key}) : super(key: key);

  @override
  _SecurityState createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  final TextEditingController _oldPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _repeatPassController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _obscureOldText = true;
  bool _obscureNewText = true;
  bool _obscureRepeatText = true;
  String _currentPassword = "";
  var userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection('others')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          _currentPassword = documentSnapshot.get("password");
        });
      }
    });
  }

  _toggleOldPass() {
    setState(() {
      _obscureOldText = !_obscureOldText;
    });
  }

  _toggleNewPass() {
    setState(() {
      _obscureNewText = !_obscureNewText;
    });
  }

  _toggleRepeatPass() {
    setState(() {
      _obscureRepeatText = !_obscureRepeatText;
    });
  }

  Future<void> _updatePassword() async {
    if (_oldPassController.text == _currentPassword) {
      try {
        final response = await FirebaseAuth.instance.currentUser!
            .updatePassword(_newPassController.text);

        CollectionReference users =
            FirebaseFirestore.instance.collection('users');

        users
            .doc(userId)
            .update({'password': _newPassController.text})
            .then(
              (value) => Fluttertoast.showToast(
                msg: 'Password updated successfully',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.grey[800],
                textColor: Colors.white,
                fontSize: 16.0,
              ),
            )
            .catchError(
              (error) => Fluttertoast.showToast(
                msg: 'Failed to update password $error',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.grey[800],
                textColor: Colors.white,
                fontSize: 16.0,
              ),
            );
      } catch (error) {
        print("ERRORLIS: " + error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              labelText: 'Old password',
              hintText: 'Old password',
              suffixIcon: IconButton(
                onPressed: () => _toggleOldPass(),
                icon: Icon(
                  _obscureOldText ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Old password is required';
              }
              if (value.length <= 4) {
                return 'Password too short.';
              }
              return null;
            },
            obscureText: _obscureOldText,
            controller: _oldPassController,
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              labelText: 'New password',
              hintText: 'New password',
              suffixIcon: IconButton(
                onPressed: () => _toggleNewPass(),
                icon: Icon(
                  _obscureNewText ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'New password is required';
              }
              if (value.length <= 4) {
                return 'Password too short.';
              }
              return null;
            },
            obscureText: _obscureNewText,
            controller: _newPassController,
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              labelText: 'Repeat new password',
              hintText: 'Repeat new password',
              suffixIcon: IconButton(
                onPressed: () => _toggleRepeatPass(),
                icon: Icon(
                  _obscureRepeatText ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Retype new password to continue';
              }
              if (value.length <= 4) {
                return 'Password too short.';
              }
              if (value != _newPassController.text) {
                return 'Password does not match';
              }
              return null;
            },
            obscureText: _obscureRepeatText,
            controller: _repeatPassController,
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(
            height: 21,
          ),
          Container(
            padding: const EdgeInsets.all(5),
            width: double.infinity,
            color: Constants.primaryColor,
            child: TextButton(
              onPressed: () {},
              child: TextRopa(
                text: 'Update new password',
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                align: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
