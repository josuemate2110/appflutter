import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutterapp/main.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future<bool> login() async {
    final firebase = FirebaseAuth.instance;
    final google = GoogleSignIn();
    final account = await google.signIn();
    if (account == null) return false;
    final authentication = await account.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: authentication.idToken,
      accessToken: authentication.accessToken,
    );
    await firebase.signInWithCredential(credential);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final navigator = Navigator.of(context);
            final userExists = await login();
            if (userExists) {
              navigator.pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const MyHomePage(
                    title: "Hola",
                  ),
                ),
              );
            }
          },
          child: const Text("Inisiar Sesion Google"),
        ),
      ),
    );
  }
}
