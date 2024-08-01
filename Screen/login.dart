import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signInAnonymously() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      print('signed in: ${userCredential.user}');
      Navigator.of(context).pushReplacementNamed('/activityAssignment');
    } catch (e) {
      print('Failed to sign in: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: signInAnonymously,
          child: const Text('Sign in Anonymously'),
        ),
      ),
    );
  }
}
