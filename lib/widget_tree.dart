import 'package:flutter/material.dart';
import 'package:new_user_login/auth.dart';
import 'package:new_user_login/pages/home_page.dart';
import 'package:new_user_login/pages/login_page.dart';
import 'package:new_user_login/pages/register_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.emailVerified) {
          return HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
