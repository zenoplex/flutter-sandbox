import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class HappyScreen extends StatefulWidget {
  const HappyScreen({super.key});

  @override
  State<HappyScreen> createState() => _HappyScreenState();
}

class _HappyScreenState extends State<HappyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Happy Happy!'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("I'm happy!"),
          onPressed: () {
            FirebaseAnalytics.instance.logEvent(name: 'Happy');
          },
        ),
      ),
    );
  }
}

class AuthenticationDemo extends StatelessWidget {
  const AuthenticationDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Image.asset('assets/logo.jpg'),
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  action == AuthAction.signIn
                      ? 'Sign in to continue'
                      : 'Create an account',
                ),
              );
            },
            footerBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 32.0),
                child: Text(
                  'Powered by me!',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
          );
        }
        return const HappyScreen();
      },
    );
  }
}
