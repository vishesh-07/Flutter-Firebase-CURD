import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire/Services/auth.dart';
import 'package:flutter_fire/signup.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _key = GlobalKey<FormState>();
  var _purple = Colors.deepPurple;
  var _white = Colors.white;
  var _email = TextEditingController();
  var _pass = TextEditingController();
  final _auth=Authentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepPurple,
        child: Center(
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      TextFormField(
                        controller: _email,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Email cannot be empty';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.white)),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      TextFormField(
                        controller: _pass,
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password cannot be empty';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.white)),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.0083),
                      FlatButton(
                        child: Text('Not registerd? Sign up'),
                        onPressed: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => SignUp(),
                            ),
                          );
                        },
                        textColor: Colors.white,
                      ),
                      SizedBox(height: 30),
                      ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width*0.9,
                                                  child: RaisedButton(
                          child: Text('Login',style: TextStyle(fontWeight: FontWeight.bold,color: _purple),),
                          onPressed: () {
                            if (_key.currentState.validate()) {
                              loginUser();
                            }
                          },
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginUser() async{
    dynamic authResult=await _auth.loginUser(_email.text, _pass.text);
    if(authResult==null){
      print('Login Error');
       _email.clear();
      _pass.clear();
    }else{
      _email.clear();
      _pass.clear();
      Navigator.pushNamed(context, '/dashboard');
    }
  }
}
