
import 'package:firabase_advansed/pages/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthServise{
  static final _auth=FirebaseAuth.instance;

  static bool isLogedIn(){
    final User? firabaseUser=_auth.currentUser;
    return firabaseUser !=null;
  }


  static Future<User?> signInUser(String email,String password) async{
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    final User firabaseUser=_auth.currentUser!;
    return firabaseUser;
  }

  static Future<User?> signUpUser(String fullname,String email,String password)async{
    var authResult=await _auth.createUserWithEmailAndPassword(email: email, password: password);
    User? user=authResult.user;
    return user;

  }


  static void signOutUser(BuildContext context){
    _auth.signOut();
    Navigator.pushReplacementNamed(context, SignInPage.route);
  }
}