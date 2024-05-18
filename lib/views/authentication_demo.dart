import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class PollScreen extends StatefulWidget {
  const PollScreen({super.key});

  @override
  State<PollScreen> createState() => _PollScreenState();
}

class _PollScreenState extends State<PollScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.icecream),
              Text('Ice-cream'),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {vote(true);},
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.local_pizza),
              Text('Pizza'),
            ],
          ),
        ),
      ],
    );
  }
}

/// Vote
Future<void> vote(bool voteForPizza) async {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final CollectionReference collection = db.collection('poll');
  final QuerySnapshot snapshot = await collection.get();

  print(snapshot.docs[0].id);
}

class HappyScreen extends StatefulWidget {
  const HappyScreen({super.key});

  @override
  State<HappyScreen> createState() => _HappyScreenState();
}

class _HappyScreenState extends State<HappyScreen> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text("I'm happy!"),
      onPressed: () {
        FirebaseAnalytics.instance.logEvent(name: 'Happy');
      },
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
        return Scaffold(
          appBar: AppBar(
            title: const Text('Happy Happy!'),
          ),
          body: const Column(
            children: [HappyScreen(), PollScreen()],
          ),
        );
      },
    );
  }
}
