import 'dart:io';
import 'package:flutter/material.dart';
import '../pickers/user_image.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String username,
    String password,
    String email,
    File image,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;
  final bool isLoading;
  AuthForm(this.submitFn, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String userEmail = '';
  String userPass = '';
  String userName = '';
  File image;
  var isLogin = true;
  File _userImageFile;

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (!isLogin && _userImageFile == null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please insert an image'),
      ));
      return;
    }
    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        userName.trim(),
        userPass.trim(),
        userEmail.trim(),
        _userImageFile,
        isLogin,
        context,
      );
    }
    print(userName);
  }

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isLogin) UserImagePicker(_pickedImage),
                  TextFormField(
                    key: ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (val) {
                      if (val.isEmpty || !val.contains('@')) {
                        return 'Please enter a valid email';
                      } else
                        return null;
                    },
                    onSaved: (val) {
                      userEmail = val;
                    },
                  ),
                  if (!isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                      validator: (val) {
                        if (val.isEmpty || val.length < 4) {
                          return 'Please enter a longer username';
                        } else
                          return null;
                      },
                      onSaved: (val) {
                        userName = val;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('pass'),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (val) {
                      if (val.isEmpty || val.length < 7) {
                        return 'Please enter a stronger password';
                      } else
                        return null;
                    },
                    onSaved: (val) {
                      userPass = val;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      child: Text(isLogin ? 'Login' : 'Signup'),
                      onPressed: _trySubmit,
                    ),
                  if (!widget.isLoading)
                    FlatButton(
                      child: Text(isLogin
                          ? 'Create account'
                          : 'Already have an account'),
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      textColor: Theme.of(context).primaryColor,
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
