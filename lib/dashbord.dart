import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire/Database/database.dart';
import 'package:flutter_fire/Services/auth.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var _white = Colors.white;
  var _purple = Colors.deepPurple;
  var _name = TextEditingController();
  var _phone = TextEditingController();
  var _city = TextEditingController();
  List userData = [];
  String userId="";
  Authentication _auth = Authentication();
  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchUserInfo();
  }

  fetchUserData() async {
    dynamic result = await DatabaseManager().getUsersList();
    if (result == null) {
      print('No Data');
    } else {
      setState(() {
        userData = result;
      });
    }
  }
  fetchUserInfo() async {
    User getUser = FirebaseAuth.instance.currentUser;
    userId = getUser.uid;
  }
  updateUserData(String name, String phone, String city, String userID) async {
    await DatabaseManager().updateUserData(name, phone, city, userID);
    fetchUserData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: _purple,
          automaticallyImplyLeading: false,
          actions: [
            FlatButton(
              color: _purple,
              onPressed: () {
                openDialougeBox(context);
              },
              child: Icon(
                Icons.edit_outlined,
                color: _white,
              ),
            ),
            FlatButton(
              color: _purple,
              onPressed: () async {
                await _auth
                    .logoutUser()
                    .then((value) => Navigator.of(context).pop(true));
              },
              child: Icon(
                Icons.logout,
                color: _white,
              ),
            )
          ],
        ),
        body: Container(
            child: ListView.builder(
                itemCount: userData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: _purple,
                      child: Column(
                        children: [
                          Text(userData[index]['name']),
                          Text(userData[index]['phone']),
                          Text(userData[index]['city']),
                        ],
                      ),
                    ),
                  );
                })));
  }

  openDialougeBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: _purple,
            title: Text('Edit Profile'),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                children: [
                  TextFormField(
                    controller: _name,
                    style: TextStyle(color: _white),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Enter Name',
                        labelText: 'Enter Your Name'),
                  ),
                  TextFormField(
                    controller: _phone,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: _white),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        hintText: 'Enter Phone No.',
                        labelText: 'Enter Your Phone No.'),
                  ),
                  TextFormField(
                    controller: _city,
                    style: TextStyle(color: _white),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_city),
                        hintText: 'Enter City',
                        labelText: 'Enter Your City'),
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                children: [
                  FlatButton(
                    color: _white,
                    child: Row(
                      children: [
                        Text(
                          'Submit',
                          style: TextStyle(color: _purple),
                        ),
                        Icon(
                          Icons.check,
                          color: _purple,
                        )
                      ],
                    ),
                    onPressed: () {
                      updateData(context);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  FlatButton(
                    color: _white,
                    child: Row(
                      children: [
                        Text(
                          'Cancel',
                          style: TextStyle(color: _purple),
                        ),
                        Icon(
                          Icons.cancel,
                          color: _purple,
                        )
                      ],
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          );
        });
  }

  updateData(BuildContext context) {
    updateUserData(_name.text, _phone.text, _city.text, userId);
  }
}
