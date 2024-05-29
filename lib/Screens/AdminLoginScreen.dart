import 'package:finalsemproject/Screens/AdminBottomNavBar.dart';
import 'package:finalsemproject/Screens/EditorBottomNavScreen.dart';
import 'package:finalsemproject/Screens/ReaderBottomNavScreen.dart';
import 'package:finalsemproject/Screens/ReaderSignUpScreen.dart';
import 'package:finalsemproject/Screens/ReaderSubcriptionScreen.dart';
import 'package:finalsemproject/Screens/SendPerposal.dart';
import 'package:finalsemproject/Screens/WriterBottomNavScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finalsemproject/API.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  TextEditingController reaemailcon = TextEditingController();
  TextEditingController reapasscount = TextEditingController();
  bool islogin = false;

  Future<void> saveUserId(String? userId, String? UserName, String? Image, String? Balance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId ?? '');
    await prefs.setString('UserName', UserName ?? '');
    await prefs.setString('Image', Image ?? '');
    await prefs.setString('Balance', Balance ?? '');
  }

  Future<void> saveReaderId(String? Reader_ID, String? Username1, String? UserImage1, String? Subscription, String? Balance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('Reader_ID', Reader_ID ?? '');
    await prefs.setString('Username1', Username1 ?? '');
    await prefs.setString('UserImage1', UserImage1 ?? '');
    await prefs.setString('Subscription', Subscription ?? '');
    await prefs.setString('Balance', Balance ?? '');
  }

  Future<void> saveAdminData(String? Admin_ID,String? UserName, String? Email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('Admin_ID', Admin_ID ?? '');
    await prefs.setString('UserName', UserName?? '');
    await prefs.setString('Email', Email?? '');
  }

  Future<void> loginUser(String email, String password) async {
    const String baseurl2 = APIHandler.baseUrl1;
    const String baseurl3 = APIHandler.baseUrl2;
    final Uri apiUrl = Uri.parse('$baseurl2/Admin/Login?email=$email&Username=$password');

    try {
      final response = await http.post(apiUrl);

      if (response.statusCode == 200) {
        islogin = true;
        String ?Admin_ID;
        String?UserName;
        String?Email;
        final jsonData = json.decode(response.body);
        if(islogin) {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) =>
                  AdminBottomNavScreen()));
        }

          Admin_ID = jsonData['Admin_ID']?.toString();
         UserName=jsonData['UserName']?.toString();
         Email=jsonData['Email']?.toString();
        saveAdminData(Admin_ID,UserName,Email);
        // Extract the user ID based on the role

        // Navigate to the appropriate screen based on the role



      } else if (response.statusCode == 404 || response.statusCode == 400) {
        // Invalid email or password
        _showErrorDialog('Email and Password Mismatch');
      } else {
        // Other errors
        _showErrorDialog('An error occurred: ${response.statusCode}');
      }
    } catch (error) {
      _showErrorDialog('An error occurred: $error');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'ERROR',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: Text(
            message,
            style: TextStyle(fontSize: 15),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(
          'ADMIN LOGIN SCREEN',
          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'BigshotOne'),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('Images/SplashScreen45.png'), // Your background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black,
                      width: 6,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 30),
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
                      SizedBox(height: 10),
                      TextFormField(
                        controller: reapasscount,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                          hintText: 'Admin Name',
                          hintStyle: TextStyle(fontFamily: 'BigshotOne'),
                          labelText: 'Admin Name',
                          labelStyle: TextStyle(fontFamily: 'BigshotOne'),
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: InkWell(
                        onTap: () async {
                          print(reaemailcon.text);
                          print(reapasscount.text);
                          loginUser(reaemailcon.text, reapasscount.text);

                        },
                        child: Text(
                          'LOGIN',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'BigshotOne'),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

              ],
            ),
          ),
        ],
      ),
    );
  }

}