import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

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
          onPressed: () {
            vote('icecream');
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.icecream),
              Text('Ice-cream'),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            vote('pizza');
          },
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

Future<void> vote(String fieldName) async {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final DocumentReference docRef = db.collection('poll').doc('document_id');
  docRef.update({fieldName: FieldValue.increment(1)});
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

class UploadFile extends StatefulWidget {
  const UploadFile({super.key});

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  File? _file;
  String? _message;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              getImage();
            },
            child: const Text('Choose file'),
          ),
          Column(
            children: [
              SizedBox(
                height: 300,
                child: _file == null
                    ? const Text('No file chosen')
                    : Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.file(_file!),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(10),
                            ),
                            child: const Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                _message = null;
                                _file = null;
                              });
                            },
                          ),
                        ],
                      ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Should be some custom UnexpectedError.
                  if (_file == null) {
                    throw Exception("File should be chosen: $_file");
                  }
                  uploadImage(_file!);
                },
                child: const Text('Upload Image'),
              ),
            ],
          ),
          Text(_message ?? ''),
        ],
      ),
    );
  }

  Future<void> getImage() async {
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file == null) return;

    setState(() {
      _file = File(file.path);
    });
  }

  // Should be in a separate service
  Future<void> uploadImage(File file) async {
    final String fileName = path.basename(file.path);
    final FirebaseApp app = Firebase.app();
    // Using different bucket
    final Reference ref = FirebaseStorage.instanceFor(
      app: app,
      bucket: FlutterConfig.get('FIREBASE_STORAGE_BUCKET') as String,
    ).ref(fileName);

    final TaskSnapshot result = await ref.putFile(file);
    final String message = result.state == TaskState.success
        ? 'File uploaded'
        : 'Error uploading file';

    setState(() {
      _message = message;
    });
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
            children: [HappyScreen(), PollScreen(), UploadFile()],
          ),
        );
      },
    );
  }
}
