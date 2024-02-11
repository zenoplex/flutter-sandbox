import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoggedIn = false;
  String name = "";
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _emailRegexp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Center(child: isLoggedIn ? _buildSuccess() : _buildLoginForm()));
  }

  void _validate() {
    final form = _formKey.currentState;

    if (form?.validate() ?? false) {
      return;
    }
    // TODO: Implement login logic
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
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
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter the runner\'s email.';
              }
              if (!_emailRegexp.hasMatch(value)) {
                return 'Enter a valid email.';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _validate,
            child: const Text('Continue'),
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
