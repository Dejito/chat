import 'dart:io';
import 'package:chatter/widget/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {


  const AuthForm( this.submitFn, this.isLoading);

    final Function(String username, String email, String password, bool isLoggedIn,File firebaseImage,BuildContext context, ) submitFn;
    final bool isLoading;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {

  bool _isVisible = true;

   bool _isLogin = true;

  String _userEmail = '';

  String _userName = '';

  String _password = '';

   File _fireBaseImage  = File('');

  final _formKey = GlobalKey<FormState>();

  void _firebaseImage(File image) {
    _fireBaseImage = image;
  }

  void _trySubmit () {
    final submit = _formKey.currentState?.validate();

    if (_fireBaseImage.path.isEmpty && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please pick an image.'),
            backgroundColor: Theme.of(context).errorColor,
          ),
      );
      return;
    }
    if(submit!) {
      _formKey.currentState?.save();
      widget.submitFn(_userName.trim(), _userEmail.trim(), _password.trim(), _isLogin, _fireBaseImage, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Center(
        child: Card(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if(!_isLogin)
                     Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                      UserImagePicker(pickedImagePass: _firebaseImage),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        key: const ValueKey('email'),
                        decoration:  const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10))
                          ),
                          label: Text('Email address'),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value){
                         if (value!.isEmpty){
                           return 'Enter a valid email address';
                         }
                         return null;
                        },
                        onSaved: (value){
                          _userEmail = value!;
                        },
                      ),
                    ),
                    if(!_isLogin)
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        key: const ValueKey('username'),
                        decoration: const InputDecoration(
                          border:  OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          label: Text('Username'),
                        ),
                        validator: (value){
                          if (value!.isEmpty || value.length<4){
                            return 'Username should be at least four characters';
                          }
                          return null;
                        },
                        onSaved: (value){
                          _userName = value!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        key: const ValueKey('password'),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          label: const Text('Password'),
                          suffixIcon: IconButton(
                              onPressed: (){
                                setState(() {
                                  _isVisible = !_isVisible;
                                });
                              },
                              icon: Icon(
                                _isVisible ? Icons.visibility_off : Icons.visibility
                              )
                          ),
                        ),
                        obscureText: _isVisible,
                        validator: (value){
                          if(value!.isEmpty || value.length<6){
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        onSaved: (value){
                          _password = value!;
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    if(widget.isLoading)
                      const CircularProgressIndicator(),
                    if(!widget.isLoading)
                    ElevatedButton(
                        onPressed: (){
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          _trySubmit();
                        },
                        child: Text(
                          _isLogin ? 'Login' : 'Signup'
                        )
                    ),
                    TextButton(
                        onPressed: (){
                          setState(() {
                            _isLogin =! _isLogin;
                          });
                        },
                        child: Text(
                            _isLogin ? 'Create new account' : 'I already have an account'
                        ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
