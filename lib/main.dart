import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './src/views/HomeView.dart';
import './src/views/LoginView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import './src/services/AuhtenticationService.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp(
        title: "Flutter Project",
        home: AuthWrapper()
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      return Home();
    }
    return LoginView();
  }
}