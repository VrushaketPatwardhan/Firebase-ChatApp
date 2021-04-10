import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);

  final bool isLoading;

  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
  ) submitFn;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  var _isLogin = false;
  var _userEmail = "";
  var _userName = "";
  var _userPassword = "";

  void _trySubmit() {
    final isValid = _formkey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formkey.currentState.save();
      widget.submitFn(
        _userEmail,
        _userPassword,
        _userName,
        _isLogin,
      );
      // if (!_isLogin)
      //   Scaffold.of(context).showSnackBar(SnackBar(
      //     content: Text(
      //       "User signed in successfully",
      //       style: TextStyle(color: Colors.white),
      //     ),
      //     backgroundColor: Colors.black,
      //   ));
      // if (_isLogin)
      //   Scaffold.of(context).showSnackBar(SnackBar(
      //     content: Text(
      //       "User Created Succesfully!",
      //       style: TextStyle(color: Colors.white),
      //     ),
      //     backgroundColor: Colors.black,
      //   ));
      // print(_userEmail);
      // print(_userName);
      // print(_userPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.purple,
              width: 4,
            ),
            borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    key: ValueKey('Email'),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      labelStyle: TextStyle(color: Colors.green),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  if (_isLogin)
                    TextFormField(
                      key: ValueKey('Username'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return "Username must be atleast 7 characters long";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Username",
                        labelStyle: TextStyle(color: Colors.amber),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('Password'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return "Password must be atleast 7 characters long";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      //focusedBorder: InputBorder.none,
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.blue),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    obscureText: true,
                    onSaved: (value) {
                      _userPassword = value;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      elevation: 6,
                      textColor: Colors.white,
                      onPressed: _trySubmit,
                      child: Text(!_isLogin ? "Login" : "Signup"),
                    ),
                  if (!widget.isLoading)
                    FlatButton(
                        textColor: Colors.red,
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(!_isLogin
                            ? "Create New Account"
                            : "I already have an account"))
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     primary: Colors.pink, // background
                  //     onPrimary: Colors.white, // foreground
                  //     shape: const BeveledRectangleBorder(
                  //         borderRadius: BorderRadius.all(Radius.circular(5))),
                  //   ),
                  //   onPressed: () {},
                  //   child: Text("Login"),
                  // ),
                  // TextButton(
                  //     onPressed: () {},
                  //     child: Text(
                  //       "Create New Account",
                  //       style: TextStyle(color: Colors.red),
                  //     )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
