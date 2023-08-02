import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_user_login/services/auth.dart';
import 'package:new_user_login/pages/login_page.dart';
import 'package:quickalert/quickalert.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
        (route) => false);
  }

  _signOutAlert() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      text: 'Do you want to logout',
      onConfirmBtnTap: signOut,
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      confirmBtnColor: Colors.green,
    );
  }

  Widget _title() {
    return const Text(
      "Brew Crew",
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _userUid() {
    return Text(user?.email ?? "User Email");
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: _signOutAlert,
      style: ElevatedButton.styleFrom(backgroundColor: Colors.brown[400]),
      child: Container(
        width: 80,
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: const Text(
          "Sign out",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _sizedBox() {
    return const SizedBox(
      height: 15,
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
            _userUid(),
            _sizedBox(),
            _signOutButton(),
          ],
        ),
      ),
    );
  }
}
