import 'package:finalsemproject/Screens/WriterAcceptedProjectsScreen.dart';
import 'package:finalsemproject/Screens/WriterLoginScreen.dart';
import 'package:finalsemproject/Screens/WriterNotificationScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:finalsemproject/API.dart';
import 'dart:convert';
import 'package:badges/badges.dart';


class EditorBalanceRequestScreen extends StatefulWidget {
  const EditorBalanceRequestScreen({super.key});

  @override
  State<EditorBalanceRequestScreen> createState() => _EditorBalanceRequestScreenState();
}

class _EditorBalanceRequestScreenState extends State<EditorBalanceRequestScreen> {
  List<Map<String, dynamic>> notifications = [];
  final Color mateBlack = Color(0xFF242424);
  final Color parotgreen=Color(0xFFADE338);
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
    final String baseurl=APIHandler.baseUrl1;
    final Responce=await http.put(Uri.parse('$baseurl/Admin/AcceptBalanceRequest?id=$id'));
    if(Responce.statusCode==200)
      {
        final snackBar = SnackBar(content: Text('Balance request accepted and reader\'s balance updated.', style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Rye'
        ),));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    else{
      final snackBar = SnackBar(content: Text('Failed to accept balance request.', style: TextStyle(
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
    final String baseurl=APIHandler.baseUrl1;
    final Responce=await http.put(Uri.parse('$baseurl/Admin/RejectBalanceRequest?id=$id'));
    if(Responce.statusCode==200)
    {
      final snackBar = SnackBar(content: Text('Reject Balance Request', style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Rye'
      ),));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else{
      final snackBar = SnackBar(content: Text('Failed To Reject Balance Request.', style: TextStyle(
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

    //getSentProposalsIdsWithEditorNotification(2);

  }
  int _notificationCount = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('Images/man2.webp'),

                    ),
                    SizedBox(width: 10,),
                    Column(children: [
                      Text('Faizan Mustafa',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),
                      ),
                      Text('Balance:2000',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)
                    ],),
                    SizedBox(width: 5,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // Close the drawer
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],)
            ),

            ListTile(
              title: Text('Home',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
              onTap: () {
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(

              title: Text('Notifiactions',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>WriterNotificationScreen()));
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
              },

            ),
            ListTile(
              title: Text('Accepted Project',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>WriterAcceptedProjectsScreen1()));
                // Add your action when the item is tapped
                // Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: Text('Recharge Balance',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
              onTap: () {
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: Text('Account Setting',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>WriterLoginscreen()));
                  },
                  child: Text
                    ('LOGOUT',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.red),),
                ),
              ),
            ),
            // Add more ListTiles for additional items in the drawer
          ],
        ),
      ),
      appBar: AppBar(


        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text('History',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white,fontFamily: 'BigshotOne'),),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
          child: Stack(children: [

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
        duration:Duration(milliseconds: 500),
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
              duration:Duration(milliseconds: 500),
              height: 150,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(imagePath), // Use Image.network for remote images
            ),
            SizedBox(width: 10),
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
                    Text(
                      ('Balance Request'),
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Rye'
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          '  Name: $name  ',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          '  Baalnce: $Balance',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                        SizedBox(width: 5),

                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          '  Status:',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          status,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
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
                              child: Center(
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
                              child: Center(
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
