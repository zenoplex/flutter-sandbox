import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoggedIn = false;
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Center(child: isLoggedIn ? _buildSuccess() : _buildLoginForm()));
  }

  Widget _buildLoginForm() {
    return const Form(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: []),
      ),
    );
  }

  Widget _buildSuccess() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [],
    );
  }
}
