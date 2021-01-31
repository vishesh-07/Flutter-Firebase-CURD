import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire/Services/auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _key = GlobalKey<FormState>();
  final Authentication _authentication = Authentication();
  var _email = TextEditingController();
  var _password = TextEditingController();
  var _name = TextEditingController();
  var _phone = TextEditingController();
  var _city = TextEditingController();
  var _white = Colors.white;
  var _purple = Colors.deepPurple;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: _purple,
        child: Center(
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: _white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _name,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Name cannot be empty';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Your Name',
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.person),
                    ),
                    style: TextStyle(color: _white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _email,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Email ID cannot be empty';
                      } else {
                        return null;
                      }
                    },
                    style: TextStyle(color: _white),
                    decoration: InputDecoration(
                      hintText: 'Enter Your Email-Id',
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.mail),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _password,
                    obscureText: true,
                    style: TextStyle(color: _white),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Password cannot be empty';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Your Password',
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _phone,
                    style: TextStyle(color: _white),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Phone No. cannot be empty';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Your Phone No.',
                      labelText: 'Phone',
                      prefixIcon: Icon(Icons.phone),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _city,
                    style: TextStyle(color: _white),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'City cannot be empty';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Your City',
                      labelText: 'City',
                      prefixIcon: Icon(Icons.location_city),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width * 0.9,
                    child: RaisedButton(
                        color: _white,
                        child: Text(
                          'SignUp',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: _purple),
                        ),
                        onPressed: () {
                          if (_key.currentState.validate()) {
                            createUser();
                          }
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: _white),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createUser() async {
    dynamic result = await _authentication.createNewUser(
        _name.text, _email.text, _password.text, _phone.text, _city.text);
    if (result == null) {
      print('Email is not valid');
    } else {
      print(result.toString());
      _name.clear();
      _email.clear();
      _password.clear();
      _phone.clear();
      _city.clear();
      Navigator.pop(context);
    }
  }
}
