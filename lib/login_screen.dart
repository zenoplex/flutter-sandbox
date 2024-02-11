import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoggedIn = false;
  String name = "";
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Center(child: isLoggedIn ? _buildSuccess() : _buildLoginForm()));
  }

  Widget _buildLoginForm() {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Runner'),
            validator: (value) {
              return value!.isEmpty ? 'Enter the runner\'s name.' : null;
            },
          ),
        ]),
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
