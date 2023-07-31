import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_user_login/auth.dart';
import 'package:new_user_login/pages/home_page.dart';
import 'package:new_user_login/pages/register_page.dart';
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
        await Auth().sendEmailVerify();
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
            (route) => false);
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
          setState(
            () {
              isVerified = Auth().currentUser!.emailVerified;
            },
          );
        }
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.brown[400]),
      child: Container(
        width: 80,
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: const Text(
          'Sign in',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const RegisterPage()),
        );
      },
      child: const Text('Register instead'),
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
      "welcome back our brew mate!",
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
  }
}
