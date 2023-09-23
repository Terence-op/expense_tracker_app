// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../providers/auth.dart';
import '../reusable_widgets/reusable_widgets.dart';
import '../utils/color_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isLoading = false;
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _phoneNoTextController = TextEditingController();
  final TextEditingController _addressTextController = TextEditingController();

  void validateFields() async {
    if (_userNameTextController.text.isEmpty) {
      showSnackBar('The user name is required');
    } else if (_emailTextController.text.isEmpty) {
      showSnackBar('The email is required');
    } else if (_passwordTextController.text.isEmpty) {
      showSnackBar('The password is required');
    } else if (_phoneNoTextController.text.isEmpty) {
      showSnackBar('The phone number is required');
    } else if (_addressTextController.text.isEmpty) {
      showSnackBar('The address is required');
    } else {
      try {
        setState(() => _isLoading = true);
        await Auth.signUp(
            name: _userNameTextController.text,
            phone: int.parse(_phoneNoTextController.text),
            address: _addressTextController.text,
            email: _emailTextController.text,
            pwd: _passwordTextController.text);
        showSnackBar('Account created successfully');
        Navigator.of(context).pop();
      } catch (e) {
        showSnackBar(e.toString());
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  void showSnackBar(String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(error),
      showCloseIcon: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                hexStringToColr("#c7cc3f"),
                hexStringToColr("#e0bf16"),
                hexStringToColr("#e02716")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter UserName", Icons.person_outlined,
                    false, _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Email Id", Icons.email_outlined, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outline, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Phone Number", Icons.call_outlined,
                    false, _phoneNoTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Address", Icons.home_outlined, false,
                    _addressTextController),
                const SizedBox(
                  height: 20,
                ),
                FirebaseButton(
                    isLoading: _isLoading,
                    context: context,
                    title: 'Sign Up',
                    onTap: () {
                      validateFields();
                    })
              ],
            ),
          ))),
    );
  }
}
