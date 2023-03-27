import 'package:firabase_advansed/pages/create_page.dart';
import 'package:firabase_advansed/pages/home_page.dart';
import 'package:firabase_advansed/pages/sign_up_page.dart';
import 'package:firabase_advansed/pages/signin_page.dart';
import 'package:firabase_advansed/pages/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(const MyApp());


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
      routes: {
        SplashPage.route:(context) =>const SplashPage(),
        SignInPage.route:(context) =>const SignInPage(),
        HomePage.route:(context) =>const HomePage(),
        SignUpPage.route:(context) =>const SignUpPage(),
        CreatePage.route:(context) =>const CreatePage(),
      },
    );
  }
}
