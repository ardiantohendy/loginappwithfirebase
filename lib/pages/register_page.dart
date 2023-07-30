import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? errorMessage = "";

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      if (Auth().currentUser!.emailVerified == false) {
        _sendVerifyAlert();
        Auth().sendEmailVerify();
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
      _errorMessage();
    }
  }

  Widget _title() {
    return const Text(
      "Brew Crew",
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      // obscureText: true, this is for password field
      decoration: InputDecoration(labelText: title),
    );
  }

  Widget _entryFieldPassword(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(labelText: title),
    );
  }

  _sendVerifyAlert() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: 'Check your email, we just send your verification',
    );
  }

  _errorMessage() {
    return errorMessage == ''
        ? ''
        : QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: errorMessage,
          );
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: () {
        createUserWithEmailAndPassword();
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.brown[400]),
      child: Container(
        width: 80,
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: const Text(
          'Register',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text('Sign in instead'),
    );
  }

  Widget _sizedBox(height) {
    return SizedBox(
      height: height,
    );
  }

  Widget _titleForLogin() {
    return Text(
      "Brew Crew",
      style: TextStyle(
        fontSize: 28,
        color: Colors.brown[400],
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _textTitle() {
    return Text(
      "Please register if you want to join us!",
      style: TextStyle(
        fontStyle: FontStyle.italic,
        color: Colors.brown[400],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _titleForLogin(),
            _sizedBox(8.0),
            _textTitle(),
            _sizedBox(5.0),
            _entryField('email', _controllerEmail),
            _entryFieldPassword("password", _controllerPassword),
            _sizedBox(15.0),
            _submitButton(),
            _loginOrRegisterButton(),
          ],
        ),
      ),
    );
    ;
  }
}
