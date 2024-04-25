import 'dart:io';

import 'package:finalsemproject/Screens/ReaderLoginScreen.dart';
import 'package:finalsemproject/Screens/WriterLoginScreen.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:finalsemproject/API.dart';
import 'package:image_picker/image_picker.dart';

enum UserRole{Reader,Writer}

class ReaderSignUpScreen extends StatefulWidget {
  const ReaderSignUpScreen({super.key});

  @override
  State<ReaderSignUpScreen> createState() => _ReaderSignUpScreenState();
}

class _ReaderSignUpScreenState extends State<ReaderSignUpScreen> {
  UserRole? _selectedRole = UserRole.Reader;
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


  Future<void> signUp(String role, String email, String userName, String password, File? imagePath) async {
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

      if (imagePath != null) { // Check if imagePath is not null
        request.files.add(
          await http.MultipartFile.fromPath('Image', imagePath.path), // Use imagePath.path to get the file path
        );
      }

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
          'SIGNUP SCREEN',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.white),
        )),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Center(
              child: GestureDetector(
                onTap: getImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.black,
                  backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                  child: _imageFile == null ? Icon(Icons.person, size: 50,color: Colors.white,) : null,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: reaemailcont,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                  hintText: 'Email',
                  labelText: 'Email',
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
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
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
                  labelText: 'Password',
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Row(children: [
                  Radio(
                      value: UserRole.Reader,
                      groupValue: _selectedRole,
                      onChanged: ( UserRole? value) {
                        setState(() {
                          _selectedRole = value!;
                        });
                      }),
                  //SizedBox(width: 10,),
                  Text('Reader',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                ],),
                SizedBox(
                  width: 10,
                ),
                Row(children: [
                  Radio(

                      value: UserRole.Writer,

                      groupValue: _selectedRole,
                      onChanged: ( UserRole? value) {
                        setState(() {
                          _selectedRole = value!;
                        });
                      }),
                  //SizedBox(width: 5,),
                  Text('Writer',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                ],)
              ],
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
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(child: Text('SIGNUP',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white))),
                  ),
                )
            ),
            SizedBox(height: 10,),
           Row(children: [
             Text('Have an account?'),
             InkWell(
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>ReaderLoginScreen()));
                 },
                 child: Text('Login',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),))
           ],)
          ],
        ),
      ),
    );
  }
  void _signUp() {
    signUp(_selectedRole.toString().split('.').last, reaemailcont.text, reanamecon.text, reapasscount.text,_imageFile);

    // Implement sign up logic here
    if(_selectedRole.toString().split('.').last=='Reader')
    {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ReaderLoginScreen()));
    }
    else if(_selectedRole.toString().split('.').last=='Writer')
      {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>WriterLoginscreen()));
      }
    print('Signing up...');
  }
  @override
  void dispose() {
    reapasscount.dispose();
    reaconpasscount.dispose();
    super.dispose();
  }
}
