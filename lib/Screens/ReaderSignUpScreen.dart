import 'dart:io';

import 'package:finalsemproject/Screens/ReaderLoginScreen.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
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
  final bool _passwordsMatch = true;
  bool isSignup=false;
  File? _imageFile;
  final picker = ImagePicker();
  final List<String> _selectedCategories = [];
  final List<String> _selectedCategories1 = [];
  final List<String> _categories = [
    'Action',
    'Comedy',
    'Romantic',
    'Horror',
    'Sci-Fi',
    'Adventure',
    'Drama',
  ];

  void _toggleCategory(String category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else {
        _selectedCategories.add(category);
      }
    });

    // Call fetchWriters when categories are toggled
    // Pass selected categories as comma-separated string
  }


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


  Future<void> signUp(String role, String email, String userName, String password, File? imagePath,String Interests) async {
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
        'Interest':Interests,
      });

      if (imagePath != null) { // Check if imagePath is not null
        request.files.add(
          await http.MultipartFile.fromPath('Image', imagePath.path), // Use imagePath.path to get the file path
        );
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        isSignup=true;
        // User signed up successfully
        var responseData = await response.stream.bytesToString();
        print('User signed up successfully: $responseData');
        if(isSignup){
          Navigator.push(context, MaterialPageRoute(builder: (cintext)=>const ReaderLoginScreen()));
          print('Signing up...');
        }
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
        title: const Center(
            child: Text(
          'SIGNUP SCREEN',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.white,fontFamily: 'BigshotONe'),
        )),
        backgroundColor: Colors.black,
      ),
      body:


      Stack(children: [


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

              Center(
                child: GestureDetector(
                  onTap: getImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                    child: _imageFile == null ? const Icon(Icons.person, size: 50,color: Colors.black,) : null,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 350,
                height: 440,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF).withOpacity(0.8),
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
                          hintStyle: const TextStyle(fontFamily: 'BigshotOne'),
                          labelText: 'Email',
                          labelStyle: const TextStyle(fontFamily: 'BigshotOne'),
                          prefixIcon: const Icon(Icons.email),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: reanamecon,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                          hintText: 'Username',
                          hintStyle: const TextStyle(fontFamily: 'BigshotOne'),
                          labelText: 'Username',
                          prefixIcon: const Icon(Icons.person),
                          labelStyle: const TextStyle(fontFamily: 'BigshotOne')
                        ),
                      ),
                    ),
                    const SizedBox(
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
                          hintStyle: const TextStyle(fontFamily: 'BigshotOne'),
                          labelText: 'Password',
                          labelStyle: const TextStyle(fontFamily: 'BigshotOne'),
                          prefixIcon: const Icon(Icons.lock),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Categories',
                        labelStyle:const TextStyle(fontFamily: 'BigshotOne',color: Colors.black),
                        hintStyle: const TextStyle(fontFamily: 'BigshotOne',color: Colors.black),
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.category),
                          onPressed: () {
                            _showCategoryDialog(context);
                          },
                        ),
                      ),
                      controller: TextEditingController(
                        text: _selectedCategories.isNotEmpty
                            ? _selectedCategories.join(', ')
                            : null,
                      ),style: const TextStyle(fontFamily: 'BigshotOne',color: Colors.black),
                      readOnly: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Role:',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'BigshotOne'),
                        ),
                        const SizedBox(
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
                          const Text('Reader',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'BigshotOne'),)
                        ],),
                        const SizedBox(
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
                          const Text('Writer',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontFamily: 'BigshotOne'),)
                        ],)
                      ],
                    ),
                  ],),),
              const SizedBox(
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
                      child: const Center(child: Text('SIGNUP',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black,fontFamily: 'Jaro'))),
                    ),
                  )
              ),
              const SizedBox(height: 10,),
              Row(children: [
                const Text('Have an account?'),
                InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const ReaderLoginScreen()));
                    },
                    child: const Text('Login',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),))
              ],)
            ],
          ),
        ),
      ],)
    );
  }
  void _signUp() {
    signUp(_selectedRole.toString().split('.').last, reaemailcont.text, reanamecon.text, reapasscount.text,_imageFile,_selectedCategories.join(','));

    // Implement sign up logic here
    // if(_selectedRole.toString().split('.').last=='Reader')
    // {
    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ReaderLoginScreen()));
    // }
    // else if(_selectedRole.toString().split('.').last=='Writer')
    //   {
    //     Navigator.push(context, MaterialPageRoute(builder: (context)=>WriterLoginscreen()));
    //   }
    // if(isSignup){
    //   Navigator.push(context, MaterialPageRoute(builder: (cintext)=>ReaderLoginScreen()));
    //   print('Signing up...');
    // }

  }
  @override
  void dispose() {
    reapasscount.dispose();
    reaconpasscount.dispose();
    super.dispose();
  }


  void _showCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Categories'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _categories.length,
              itemBuilder: (BuildContext context, int index) {
                final category = _categories[index];
                return CheckboxListTile(
                  title: Text(category),
                  value: _selectedCategories.contains(category),
                  onChanged: (bool? value) {
                    _toggleCategory(category);
                  },
                );
              },
            ),
          ),


          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
