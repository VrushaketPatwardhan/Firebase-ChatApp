import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fp1/screens/auth_screen.dart';

import './screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.red,
        buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )),
      ),
      home: AuthScreen(),
    );
  }
}
