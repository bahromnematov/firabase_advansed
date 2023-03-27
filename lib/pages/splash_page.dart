import 'dart:async';

import 'package:firabase_advansed/pages/home_page.dart';
import 'package:firabase_advansed/pages/signin_page.dart';
import 'package:firabase_advansed/servise/auth_servise.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  static const route = "splash_page";

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initTimer();
  }

  void _initTimer() {
    Timer(const Duration(seconds: 2), () {
      _callNextPage();
    });
  }

  _callNextPage() {
    if (AuthServise.isLogedIn()) {
      Navigator.pushReplacementNamed(context, HomePage.route);
    } else {
      Navigator.pushReplacementNamed(context, SignInPage.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromRGBO(193, 53, 132, 1),
              Color.fromRGBO(131, 58, 180, 1)
            ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Expanded(
                child: Center(
              child: Text(
                "Welcome",
                style: TextStyle(color: Colors.white, fontSize: 35),
              ),
            )),
            Text(
              "All rights reserved",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
