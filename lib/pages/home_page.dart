import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_user_login/auth.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Text("Firebase Auth");
  }

  Widget _userUid() {
    return Text(user?.email ?? "User Email");
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      style: ElevatedButton.styleFrom(primary: Colors.white),
      child: const Text(
        "Sign in as anonymous",
        style: TextStyle(color: Colors.black),
      ),
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
          children: [_userUid(), _signOutButton()],
        ),
      ),
    );
  }
}
