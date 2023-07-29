import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_user_login/auth.dart';
import 'package:new_user_login/pages/home_page.dart';
import 'package:quickalert/quickalert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = "";
  bool isLogin = true;
  bool isVerified = false;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      if (Auth().currentUser!.emailVerified == false) {
        _sendVerifyWarningAlert();
        Auth().sendEmailVerify();
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
      _errorMessage();
    }
  }

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

  _sendVerifyWarningAlert() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.warning,
      text:
          'Your email have not verified yet!, check your email, we just send your new verification',
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
        if (isLogin) {
          signInWithEmailAndPassword();
        } else {
          createUserWithEmailAndPassword();
        }
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.brown[400]),
      child: Container(
        width: 80,
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: Text(
          isLogin ? 'Login' : 'Register',
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Register instead' : 'Login instead'),
    );
  }

  Widget _sizedBox() {
    return const SizedBox(
      height: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _entryField('email', _controllerEmail),
            _entryFieldPassword("password", _controllerPassword),
            _sizedBox(),
            _submitButton(),
            _loginOrRegisterButton(),
          ],
        ),
      ),
    );
  }
}
