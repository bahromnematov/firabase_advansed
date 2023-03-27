import 'package:firabase_advansed/pages/home_page.dart';
import 'package:firabase_advansed/pages/signin_page.dart';
import 'package:firabase_advansed/servise/auth_servise.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  static const route = "signup_page";

  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var isLoading=false;

  var emailController = TextEditingController();
  var fullnameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmpasswordController = TextEditingController();

  void _doSignUp() {
    print("mamdnnas");
    String fullname = fullnameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String cpassword = confirmpasswordController.text.toString().trim();

    if (fullname.isEmpty || email.isEmpty || password.isEmpty) return;
    if (cpassword !=password ) {
      print("Password and confirm password does not match");
      return;
    }

    setState(() {
      isLoading=true;
    });

    AuthServise.signUpUser(fullname, email, password).then((value) => {
          responseSignUp(value!),
        });
  }

  void responseSignUp(User firebaseUser) {
    setState(() {
      isLoading=true;
    });
    Navigator.pushReplacementNamed(context, HomePage.route);
  }

  void _callSignInPage() {
    Navigator.pushReplacementNamed(context, SignInPage.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromRGBO(193, 53, 132, 1),
              Color.fromRGBO(131, 58, 180, 1)
            ])),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //fulname
                Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.white54.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(7)),
                  child: TextField(
                    controller: fullnameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        hintText: "FullName",
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 17, color: Colors.white54)),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                //email
                Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.white54.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(7)),
                  child: TextField(
                    controller: emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        hintText: "Email",
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 17, color: Colors.white54)),
                  ),
                ),

                SizedBox(
                  height: 12,
                ),
                //password
                Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.white54.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(7)),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        hintText: "Password",
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 17, color: Colors.white54)),
                  ),
                ),

                SizedBox(
                  height: 12,
                ),
                //confirmpassword
                Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.white54.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(7)),
                  child: TextField(
                    obscureText: true,
                    controller: confirmpasswordController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        hintText: "Confirm Password",
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 17, color: Colors.white54)),
                  ),
                ),

                SizedBox(
                  height: 42,
                ),
                //sign in button

                InkWell(
                  onTap: _doSignUp,
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.white54.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(7)),
                    child: const Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 12,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    InkWell(
                      onTap: _callSignInPage,
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),

            isLoading ? const Center(
              child: CircularProgressIndicator(),
            ):SizedBox.shrink()
          ],
        )
      ),
    );
  }
}
