import 'package:finalsemproject/Screens/WriterAcceptedProjectsScreen.dart';
import 'package:finalsemproject/Screens/WriterLoginScreen.dart';
import 'package:finalsemproject/Screens/WriterNotificationScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:finalsemproject/API.dart';
import 'dart:convert';


class EditorBalanceRequestScreen extends StatefulWidget {
  const EditorBalanceRequestScreen({super.key});

  @override
  State<EditorBalanceRequestScreen> createState() => _EditorBalanceRequestScreenState();
}

class _EditorBalanceRequestScreenState extends State<EditorBalanceRequestScreen> {
  List<Map<String, dynamic>> notifications = [];
  final Color mateBlack = const Color(0xFF242424);
  final Color parotgreen=const Color(0xFFADE338);
  String?Admin_ID;
  String?AdminName;
  String?AdminEmail;
  // String?userId;
  // Future<void> getUserIdFromSharedPreferences() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final user = prefs.getString('userId');
  //   setState(() {
  //     userId = user;
  //   });
  //   if (userId != null) {
  //     fetchProposals();
  //   }
  // }
  Future<void> getUserIdFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final AdminId = prefs.getString('Admin_ID');
    final UserName=prefs.getString('UserName');
    final Email=prefs.getString('Email');

    setState(() {
      Admin_ID = AdminId;
      AdminName=UserName;
      AdminEmail=Email;

      print('Admin ID: $Admin_ID');
      print('AdminName: $AdminName');
      print('AdminEMail: $AdminEmail');

    });

  }

int ? id;
  Future<void> GetBalnaceRequest() async {
    const String baseurl2=APIHandler.baseUrl1;
    const String baseurl3=APIHandler.baseUrl2;
    final url = Uri.parse('$baseurl2//Admin/GetBalanceRequests');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          print(data);
          notifications = data.map((proposal) {
            int balanceId = int.tryParse(proposal['Balance_ID'].toString()) ?? 0;

            // Store the first Balance_ID into the id variable
            if (id == null) {
              setState(() {
                id = balanceId;
              });
            }

            return {

              'id': proposal['Balance_ID'],
              'Balance': proposal['Balance'],
              'Name': proposal['ReaderDetails']['UserName'],


              'imagePath': '$baseurl3/Images/${proposal['ReaderDetails']['Image']}',
              'status': proposal['Status'],
            };
          }).toList();
        });
      } else {
        throw Exception('Failed to load proposals');
      }
    } catch (error) {
      print('Error fetching proposals: $error');
    }
  }
  Future<void>AcceptBalanceRequest()async
  {
    const String baseurl=APIHandler.baseUrl1;
    final Responce=await http.put(Uri.parse('$baseurl/Admin/AcceptBalanceRequest?id=$id'));
    if(Responce.statusCode==200)
      {
        const snackBar = SnackBar(content: Text('Balance request accepted and reader\'s balance updated.', style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Rye'
        ),));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    else{
      const snackBar = SnackBar(content: Text('Failed to accept balance request.', style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Rye'
      ),));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  Future<void>RejectBalanceRequest()async
  {
    const String baseurl=APIHandler.baseUrl1;
    final Responce=await http.put(Uri.parse('$baseurl/Admin/RejectBalanceRequest?id=$id'));
    if(Responce.statusCode==200)
    {
      const snackBar = SnackBar(content: Text('Reject Balance Request', style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Rye'
      ),));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else{
      const snackBar = SnackBar(content: Text('Failed To Reject Balance Request.', style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Rye'
      ),));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }



  @override
  void initState() {
    super.initState();
    GetBalnaceRequest();
    getUserIdFromSharedPreferences();
    //getSentProposalsIdsWithEditorNotification(2);

  }
  final int _notificationCount = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('Images/man2.webp'),

                    ),
                    const SizedBox(width: 10,),
                    const Column(children: [
                      Text('Faizan Mustafa',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),
                      ),
                      Text('Balance:2000',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)
                    ],),
                    const SizedBox(width: 5,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // Close the drawer
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],)
            ),

            ListTile(
              title: const Text('Home',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
              onTap: () {
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(

              title: const Text('Notifiactions',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const WriterNotificationScreen()));
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
              },

            ),
            ListTile(
              title: const Text('Accepted Project',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const WriterAcceptedProjectsScreen1()));
                // Add your action when the item is tapped
                // Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text('Recharge Balance',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
              onTap: () {
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text('Account Setting',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
              onTap: () {
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: Container(height: 40,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(
                      color: Colors.red,
                      width: 2
                  ),

                ),
                child:

                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const WriterLoginscreen()));
                  },
                  child: const Text
                    ('LOGOUT',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.red),),
                ),
              ),
            ),
            // Add more ListTiles for additional items in the drawer
          ],
        ),
      ),
      appBar: AppBar(


        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text('Balance Request',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white,fontFamily: 'BigshotOne'),),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
          child: Stack(children: [

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
                children: notifications.map((notification) {
                  return buildNotificationCard(notification);
                }).toList(),
              ),
            ),],)
      ),
    );
  }
  Widget buildNotificationCard(Map<String, dynamic> notification) {
    final int id = notification['id'] ?? '';
    final int Balance = notification['Balance'] ?? '';

    final String name=notification['Name']??'';


    final String status = notification['status'] ?? '';

    final String imagePath = notification['imagePath'] ?? '';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        duration:const Duration(milliseconds: 500),
        height: 200,
        width: 320,
        decoration: BoxDecoration(
          color: Colors.amber,
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          //borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration:const Duration(milliseconds: 500),
              height: 150,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(imagePath), // Use Image.network for remote images
            ),
            const SizedBox(width: 10),
            Container(
              height: 210,
              width: 200,

              decoration: BoxDecoration(

                color:mateBlack,

              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: [
                    const Text(
                      ('Balance Request'),
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Rye'
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          '  Name: $name  ',
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          '  Baalnce: $Balance',
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                        const SizedBox(width: 5),

                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text(
                          '  Status:',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          status,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              AcceptBalanceRequest();
                            },
                            child: Container(
                              height: 25,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  'Accept',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontFamily: 'BigshotOne'
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              RejectBalanceRequest();
                            },
                            child: Container(
                              height: 25,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  'Reject',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontFamily: 'BigshotOne'
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),


                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
