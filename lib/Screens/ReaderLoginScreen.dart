import 'package:finalsemproject/Screens/AddAdvertisment.dart';
import 'package:finalsemproject/Screens/EditorBottomNavScreen.dart';
import 'package:finalsemproject/Screens/ReaderBottomNavScreen.dart';
import 'package:finalsemproject/Screens/ReaderSignUpScreen.dart';
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
  bool islogin = false;

  Future<void> saveUserId(String? userId, String? UserName, String? Image, String? Balance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId ?? '');
    await prefs.setString('UserName', UserName ?? '');
    await prefs.setString('Image', Image ?? '');
    await prefs.setString('Balance', Balance ?? '');
  }

  Future<void> saveReaderId(String? readerId, String? Username1, String? UserImage1, String? Subscription, String? Balance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('Reader_ID', readerId ?? '');
    await prefs.setString('Username1', Username1 ?? '');
    await prefs.setString('UserImage1', UserImage1 ?? '');
    await prefs.setString('Subscription', Subscription ?? '');
    await prefs.setString('Balance', Balance ?? '');
  }

  Future<void> saveEditorId(String? editorId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('Editor_ID', editorId ?? '');
  }

  Future<void> loginUser(String email, String password) async {
    const String baseurl2 = APIHandler.baseUrl1;
    const String baseurl3 = APIHandler.baseUrl2;
    final Uri apiUrl = Uri.parse('$baseurl2/User/Login?password=$password&email=$email');

    try {
      final response = await http.post(apiUrl);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final role = jsonData['Role'];
        final userData = jsonData['UserData'];

        // Extract the user ID based on the role
        String? userId;
        String? UserName;
        String? Image;
        String? Balance;

        String? readerId;
        String ?companyid;
        String? Username1;
        String? UserImage1;
        String? Subscription;
        String?Email;
        String?Name;
        String?Image1;
        String?Password;

        String? editorId;

        if (role == 'Editor') {
          editorId = userData['Editor_ID']?.toString();
          await saveEditorId(editorId);
        } else if (role == 'Writer') {
          userId = userData['Writer_ID']?.toString();
          UserName = userData['UserName']?.toString();
          Image = '$baseurl3/Images/${userData['Image']}';
          Balance = userData['Balance']?.toString();
          await saveUserId(userId, UserName, Image, Balance);
        } else if (role == 'Reader') {
          readerId = userData['Reader_ID']?.toString();
          Username1 = userData['UserName']?.toString();
          UserImage1 = '$baseurl3/Images/${userData['Image']}';
          Subscription = userData['Subscription']?.toString();
          Balance = userData['Balance']?.toString();
          await saveReaderId(readerId, Username1, UserImage1, Subscription, Balance);
        }else if(role=='Company'){
          companyid=userData['Company_ID']?.toString();
          Email=userData['Email']?.toString();
          Name=userData['Name']?.toString();
          Password=userData['Password'].toString();
          Image1='$baseurl3/Images/${userData['Image']}';
        }

        // Navigate to the appropriate screen based on the role
        if (role == 'Writer') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ReaderBottomNavScreen11()));
        } else if (role == 'Editor') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const EditorBottomNavScreen()));
        } else if (role == 'Reader') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ReaderBottomNavScreen()));
        }else if(role=='Company'){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddAddvertisment()));
        }

        islogin = true;
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
          title: const Text(
            'ERROR',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: Text(
            message,
            style: const TextStyle(fontSize: 15),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
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
        title: const Text(
          'LOGIN SCREEN',
          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'BigshotOne'),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('Images/SplashScreen45.png'), // Your background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black,
                      width: 6,
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: reaemailcon,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                          hintText: 'Email',
                          hintStyle: const TextStyle(fontFamily: 'BigshotOne'),
                          labelText: 'Email',
                          labelStyle: const TextStyle(fontFamily: 'BigshotOne'),
                          prefixIcon: const Icon(Icons.email),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: reapasscount,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                          hintText: 'Password',
                          hintStyle: const TextStyle(fontFamily: 'BigshotOne'),
                          labelText: 'Password',
                          labelStyle: const TextStyle(fontFamily: 'BigshotOne'),
                          prefixIcon: const Icon(Icons.lock),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
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
                          _Login();
                        },
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'BigshotOne'),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?',style: TextStyle(fontFamily: 'Jaro',fontSize: 15,color: Colors.white),),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ReaderSignUpScreen()));
                      },
                      child: const Text(
                        'Sign up',style: TextStyle(fontFamily: 'Jaro',fontSize: 15,color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _Login() {
    loginUser(reaemailcon.text, reapasscount.text);
    if(islogin)
    {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const EditorBottomNavScreen()));
    }
  }
}