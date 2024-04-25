import 'package:finalsemproject/Screens/EditorBottomNavScreen.dart';
import 'package:finalsemproject/Screens/ReaderSignUpScreen.dart';
import 'package:finalsemproject/Screens/ReaderSubcriptionScreen.dart';
import 'package:finalsemproject/Screens/SendPerposal.dart';
import 'package:finalsemproject/Screens/WriterBottomNavScreen.dart';
import 'package:flutter/material.dart';
import 'package:finalsemproject/API.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
class ReaderLoginScreen extends StatefulWidget {
  const ReaderLoginScreen({super.key});

  @override
  State<ReaderLoginScreen> createState() => _ReaderLoginScreenState();
}

class _ReaderLoginScreenState extends State<ReaderLoginScreen> {
  TextEditingController reaemailcon = TextEditingController();
  TextEditingController reapasscount = TextEditingController();
  bool islogin=false;
  Future<void> saveUserId(String ?userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId ?? '');
  }

  Future<void> loginUser(String email, String password) async {
    const String baseurl2 = APIHandler.baseUrl1;
    final Uri apiUrl =
    Uri.parse('$baseurl2/User/Login?password=' + password + '&email=' + email);

    try {
      final response = await http.post(
        apiUrl,
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final role = jsonData['Role'];
        final userData = jsonData['UserData'];

        // Extract the user ID based on the role
        String ?userId;
        if (role == 'Editor') {
          userId = '2';
        } else if (role == 'Writer') {

          userId = userData['Writer_ID']?.toString();
        }


        // Save the user ID to shared preferences
        await saveUserId(userId);
        print('Userid:${userId}');

        // Navigate to the appropriate screen based on the role
        if (role == 'Writer') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ReaderBottomNavScreen11()));
        } else if (role == 'Editor') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EditorBottomNavScreen()));
        }

        print('Login successful, Role: $role, UserID: $userId');
        islogin=true;
      } else if (response.statusCode == 404) {
        // Invalid email or password
        print('Invalid email or password${response.statusCode}');
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'ERROR',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                content: Text(
                  'Email And Password MissMatch',
                  style: TextStyle(fontSize: 15),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok'))
                ],
              );
            });
      } else if (response.statusCode == 400) {
        // Invalid user role
        print('Invalid user role');
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'ERROR',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                content: Text(
                  'Email And Password MissMatch',
                  style: TextStyle(fontSize: 15),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok'))
                ],
              );
            });
      } else {
        // Other errors
        print('Errorrrr: ${response.statusCode}');
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'ERROR',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                content: Text(
                  'Email And Password MissMatch',
                  style: TextStyle(fontSize: 15),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok'))
                ],
              );
            });
      }
    } catch (error) {
      print('Error: $error');
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(
          'Editor LOGIN SCREEN',
          style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'BigshotOne'),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: Text(
              'LOGIN',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,fontFamily: 'Rye'),
            )),
            TextFormField(
              controller: reaemailcon,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                hintText: 'Email',
                hintStyle: TextStyle(fontFamily: 'BigshotOne'),
                labelText: 'Email',
                labelStyle: TextStyle(fontFamily: 'BigshotOne'),

                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: reapasscount,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                hintText: 'Password',
                hintStyle: TextStyle(fontFamily: 'BigshotOne'),
                labelText: 'Password',
                labelStyle: TextStyle(fontFamily: 'BigshotOne'),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: InkWell(
                      onTap: ()async{
                        print(reaemailcon.text);
                        print(reapasscount.text);
                        _Login();

                        //loginUser( reaemailcon.text,reapasscount.text);

                      },
                      child: Text('LOGIN',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white,fontFamily: 'BigshotOne')))),
                )
            ),
            SizedBox(height: 10,),
            Row(children: [
              Text('Dont have an account?'),
              InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ReaderSignUpScreen()));
                  },
                  child: Text('Sign up',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,fontFamily: 'BigshotOne'),))
            ],)
          ],
        ),
      ),
    );
  }
  void _Login()
  {
    loginUser( reaemailcon.text,reapasscount.text);
    if(islogin)
      {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>EditorBottomNavScreen()));
      }
  }
}
