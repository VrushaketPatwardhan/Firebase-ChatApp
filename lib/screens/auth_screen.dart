import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var isLoading = false;
  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
  ) async {
    UserCredential authResult;
    try {
      setState(() {
        isLoading = true;
      });
      if (!isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        setState(() {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
              "User signed in successfully",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.white,
          ));
        });
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection("users")
            .doc(authResult.user.uid)
            .set({
          'username': username,
          'email': email,
        });
        setState(() {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
              "User Created Succesfully!",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black,
          ));
        });
      }
    } on PlatformException catch (err) {
      var message = "an error occured!, check your credentials";
      if (err.message == null) {
        message = err.message;
      }
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ));
      setState(() {
        isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: AuthForm(
        _submitAuthForm,
        isLoading,
      ),
    );
  }
}
