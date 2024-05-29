import 'dart:io';

import 'package:finalsemproject/Screens/AdminLoginScreen.dart';
import 'package:finalsemproject/Screens/ReaderLoginScreen.dart';
import 'package:finalsemproject/Screens/WriterLoginScreen.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:finalsemproject/API.dart';
import 'package:image_picker/image_picker.dart';

enum UserRole{Editor}

class EditorSignUpScreen extends StatefulWidget {
  const EditorSignUpScreen({super.key});

  @override
  State<EditorSignUpScreen> createState() => _EditorSignUpScreenState();
}

class _EditorSignUpScreenState extends State<EditorSignUpScreen> {
  UserRole? _selectedRole = UserRole.Editor;
  TextEditingController reaemailcont = TextEditingController();
  TextEditingController reanamecon = TextEditingController();
  TextEditingController reapasscount = TextEditingController();
  TextEditingController reaconpasscount = TextEditingController();
  bool _passwordsMatch = true;
  File? _imageFile;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }


  Future<void> signUp(String role, String email, String userName, String password) async {
    //String baseurl=APIHandler().base_url;
    //final String apiUrl = baseurl+"User/SignUp";

    try {
      var request = http.MultipartRequest('POST', Uri.parse(APIHandler.signUp1));

      request.headers['Content-Type'] = 'multipart/form-data';

      request.fields.addAll({
        'Role': role,
        'Email': email,
        'UserName': userName,
        'Password': password,
      });



      var response = await request.send();

      if (response.statusCode == 200) {
        // User signed up successfully
        var responseData = await response.stream.bytesToString();
        print('User signed up successfully: $responseData');
      } else {
        // Failed to sign up user
        print('Failed to sign up user: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error
      print('Error signing up user: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Center(
              child: Text(
                'ADD EDITOR',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.white,fontFamily: 'BigshotONe'),
              )),
          backgroundColor: Colors.black,
        ),
        body:


        Stack(children: [


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


                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: 350,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black,
                        width: 6,
                      ),
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: reaemailcont,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                              hintText: 'Email',
                              hintStyle: TextStyle(fontFamily: 'BigshotOne'),
                              labelText: 'Email',
                              labelStyle: TextStyle(fontFamily: 'BigshotOne'),
                              prefixIcon: Icon(Icons.email),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: reanamecon,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                                hintText: 'Username',
                                hintStyle: TextStyle(fontFamily: 'BigshotOne'),
                                labelText: 'Username',
                                prefixIcon: Icon(Icons.person),
                                labelStyle: TextStyle(fontFamily: 'BigshotOne')
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: reapasscount,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                              hintText: 'Password',
                              hintStyle: TextStyle(fontFamily: 'BigshotOne'),
                              labelText: 'Password',
                              labelStyle: TextStyle(fontFamily: 'BigshotOne'),
                              prefixIcon: Icon(Icons.lock),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: TextFormField(
                        //     controller: reaconpasscount,
                        //     obscureText: false,
                        //     onChanged: (value) {
                        //       setState(() {
                        //         _passwordsMatch = reapasscount == value;
                        //       });
                        //     },
                        //     decoration: InputDecoration(
                        //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                        //       hintText: 'Confirm Password',
                        //       labelText: 'Confirm Password',
                        //       errorText: reaconpasscount==reapasscount?null:'Password do not Match',
                        //       prefixIcon: Icon(Icons.lock),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              'Role:',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'BigshotOne'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Row(children: [
                              Radio(
                                  value: UserRole.Editor,
                                  groupValue: _selectedRole,
                                  onChanged: ( UserRole? value) {
                                    setState(() {
                                      _selectedRole = value!;
                                    });
                                  }),
                              //SizedBox(width: 10,),
                              Text('Editor',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'BigshotOne'),)
                            ],),
                            SizedBox(
                              width: 10,
                            ),

                          ],
                        ),
                      ],),),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: InkWell(
                      onTap: ()async{

                        _signUp();
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(child: Text('SIGNUP',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black,fontFamily: 'Jaro'))),
                      ),
                    )
                ),
                SizedBox(height: 10,),
                Row(children: [
                  Text('Have an account?'),
                  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminLoginScreen()));
                      },
                      child: Text('Login',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),))
                ],)
              ],
            ),
          ),
        ],)
    );
  }
  void _signUp() {
    signUp(_selectedRole.toString().split('.').last, reaemailcont.text, reanamecon.text, reapasscount.text);

    // Implement sign up logic here
    // if(_selectedRole.toString().split('.').last=='Reader')
    // {
    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ReaderLoginScreen()));
    // }
    // else if(_selectedRole.toString().split('.').last=='Writer')
    //   {
    //     Navigator.push(context, MaterialPageRoute(builder: (context)=>WriterLoginscreen()));
    //   }
    Navigator.push(context, MaterialPageRoute(builder: (cintext)=>AdminLoginScreen()));
    print('Signing up...');
  }
  @override
  void dispose() {
    reapasscount.dispose();
    reaconpasscount.dispose();
    super.dispose();
  }
}
