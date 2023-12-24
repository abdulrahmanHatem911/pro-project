import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'shared/services/local/components.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  static String id = "reg_screen";

  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Register",
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.start,
            ),
            buildFormFieldText(
                labelText: "Email",
                keyboardType: TextInputType.emailAddress,
                onChange: (v) {
                  email = v;
                }),
            SizedBox(
              height: 10,
            ),
            buildFormFieldText(
                labelText: "Password",
                keyboardType: TextInputType.text,
                onChange: (v) {
                  password = v;
                }),
            buildElevatedTextButton(
                backgroundColor: Colors.white,
                titleOfButton: "Register",
                titleOfButtonColor: Colors.black,
                borderColor: Colors.white,
                buttonWidth: double.infinity,
                widthOfBorder: 0,
                onPressedFunction: () async {
                  try {
                    buildRegisterUserWithEmailAndPassword(
                        email: email!, password: password!);
                    navigateNamedTO(context, HomeScreen.id, arguments: email);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                    }
                  }
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("have Account ? "),
                TextButton(
                  onPressed: () {
                    navigateNamedTOAndReplacement(context, LoginScreen.id);
                  },
                  child: Text(
                    "Login NOW",
                    style: TextStyle(color: Colors.white70),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
