import 'package:finalsemproject/Screens/EditorBottomNavScreen.dart';
import 'package:finalsemproject/Screens/ReaderSignUpScreen.dart';
import 'package:finalsemproject/Screens/ReaderSubcriptionScreen.dart';
import 'package:finalsemproject/Screens/SendPerposal.dart';
import 'package:finalsemproject/Screens/WriterBottomNavScreen.dart';
import 'package:finalsemproject/Screens/WriterNotificationScreen.dart';
import 'package:flutter/material.dart';
import 'package:finalsemproject/API.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
class WriterLoginscreen extends StatefulWidget {
  const WriterLoginscreen({super.key});

  @override
  State<WriterLoginscreen> createState() => _WriterLoginscreenState();
}

class _WriterLoginscreenState extends State<WriterLoginscreen> {
  TextEditingController Wriemailcon = TextEditingController();
  TextEditingController Wripasscount = TextEditingController();
  bool islogin=false;
  Future<void> loginUser(String email, String password) async {
    const String baseurl2=APIHandler.baseUrl1;
    final Uri apiUrl = Uri.parse('$baseurl2/User/Login?password='+password+'&email='+email); // Replace with your API URL
    print(email.toString()+password);
    try {
      final response = await http.post(
        apiUrl,
        // body: {'email': email, 'password': password},
      );
      //print(response.body.toString());

      if (response.statusCode == 200) {
        // Successful login
        final jsonData = json.decode(response.body);
        //print(jsonData);
        // Process your response here, for example:
        final role = jsonData['Role'];
        final userData = jsonData['UserData'];
        final userId = userData['Writer_ID'];
        //await saveUserId(userId.toString());
        print('Login successful, Role: $role, UserData: $userData');
         // Assuming UserId is the key in your response

          islogin=true;


      } else if (response.statusCode == 404) {
        // Invalid email or password
        print('Invalid email or password');
        showDialog(context: context, builder: (BuildContext context)
        {
          return AlertDialog(
            title: Text('ERROR',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            content: Text('Email And Passowrd MissMatch',style: TextStyle(fontSize: 15),),
            actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text('Ok'))
            ],
          );
        });

      } else if (response.statusCode == 400) {
        // Invalid user role
        print('Invalid user role');
        showDialog(context: context, builder: (BuildContext context)
        {
          return AlertDialog(
            title: Text('ERROR',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            content: Text('Email And Passowrd MissMatch',style: TextStyle(fontSize: 15),),
            actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text('Ok'))
            ],
          );
        });

      } else {
        // Other errors
        print('Error: ${response.statusCode}');
        showDialog(context: context, builder: (BuildContext context)
        {
          return AlertDialog(
            title: Text('ERROR',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            content: Text('Email And Passowrd MissMatch',style: TextStyle(fontSize: 15),),
            actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text('Ok'))
            ],
          );
        });
      }
    } catch (error) {
      print('Error: $error');
    }
  }
  // Future<void> saveUserId(String userId) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('userId', userId);
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(
          'WRITER LOGIN SCREEN',
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
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,fontFamily: 'BigshotOne'),
                )),
            TextFormField(
              controller: Wriemailcon,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                hintText: 'Email',
                hintStyle: TextStyle(fontFamily: 'Rye'),
                labelText: 'Email',
                labelStyle: TextStyle(fontFamily: 'Rye'),

                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: Wripasscount,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                hintText: 'Password',
                hintStyle: TextStyle(fontFamily: 'Rye'),
                labelText: 'Password',
                labelStyle: TextStyle(fontFamily: 'Rye'),
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
                        print(Wriemailcon.text);
                        print(Wripasscount.text);
                        _Login();
                       // loginUser( Wriemailcon.text,Wripasscount.text);

                      },
                      child: Text('LOGIN',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white,fontFamily: 'BigshotOne')))),
                )
            ),
            SizedBox(height: 10,),
            Row(children: [
              Text('Dont have an account?',style: TextStyle(fontFamily: 'Rye'),),
              InkWell(
                  onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>ReaderSignUpScreen()));
                  },
                  child: Text('Sign up',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,fontFamily: 'BigshotOne'),))
            ],)
          ],
        ),
      ),
    );
  }
  void _Login(){
    loginUser( Wriemailcon.text,Wripasscount.text);

    if(islogin){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ReaderBottomNavScreen11()));
    }
  }
}
