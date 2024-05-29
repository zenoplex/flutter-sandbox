import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_sandbox/firebase_options.dart';
import 'package:flutter_sandbox/views/animation_demo.dart';
import 'package:flutter_sandbox/views/authentication_demo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseUIAuth.configureProviders(
    [
      EmailAuthProvider(),
      GoogleProvider(
        iOSPreferPlist: true,
        scopes: ['email', 'profile'],
        clientId: FlutterConfig.get('GOOGLE_CLIENT_ID') as String,
      ),
    ],
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MasterPlanApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(
    'Notification: ${message.notification?.title} - ${message.notification?.body});',
  );
}

class MasterPlanApp extends StatelessWidget {
  const MasterPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaterialApp title',

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      routes: {
        '/': (context) => const AuthenticationDemo(),
        '/settings': (context) => const AnimationDemo(),
      },
      // onGenerateRoute: (settings) {
      //   print(settings);
      //   return MaterialPageRoute<Widget>(
      //     builder: (context) {
      //       return routes[settings.name];
      //     },
      //   );
      // },
    );
  }
}
