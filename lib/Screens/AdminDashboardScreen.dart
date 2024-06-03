import 'package:finalsemproject/Screens/WriterAcceptedProjectsScreen.dart';
import 'package:finalsemproject/Screens/WriterLoginScreen.dart';
import 'package:finalsemproject/Screens/WriterNotificationScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:finalsemproject/API.dart';
import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  List<Map<String, dynamic>> notifications = [];
  final Color mateBlack = Color(0xFF242424);
  final Color parotgreen=Color(0xFFADE338);
  String ?userId;
  String? ReaderName;
  String ?Subscription;
  String? ReaderBalance;
  String? ReaderImage;
  bool _isSearching = false;
  String _searchQuery = "";
  List<Map<String,dynamic>>notifications2=[];
  List<Map<String,dynamic>>notifications3=[];


  Future<void> fetchProposals() async {
    const String baseurl2=APIHandler.baseUrl1;
    const String baseurl3=APIHandler.baseUrl2;
    final url = Uri.parse('$baseurl2/Admin/ShowAllUser');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          notifications2 = data.map((proposal) {
            return {
              'Reader_ID': proposal['Reader_ID'],
              'Email': proposal['Email'],
              'Balance': proposal['Balance'],
              'Subscription': proposal['Subscription'],
              'Interest':proposal['Interest'],
              'UserName': proposal['UserName'],
              'imagePath': '$baseurl3/Images/${proposal['Image']}',

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
  Future<void> fetchWriters() async {
    const String baseurl2=APIHandler.baseUrl1;
    const String baseurl3=APIHandler.baseUrl2;
    final url = Uri.parse('$baseurl2/Admin/ShowAllWriters');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          notifications3 = data.map((proposal) {
            return {
              'Writer_ID': proposal['Writer_ID'],

              'Balance': proposal['Balance'],

              'Interest':proposal['Interest'],
              'UserName': proposal['UserName'],
              'imagePath': '$baseurl3/Images/${proposal['Image']}',

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


  @override
  void initState() {
    super.initState();
    fetchProposals();
    fetchWriters();

    //getSentProposalsIdsWithEditorNotification(2);

  }
  int _notificationCount = 3;
  @override
  Widget build(BuildContext context) {
    final filteredNotifications = notifications2
        .where((notification) =>
        notification['UserName']!.toLowerCase().startsWith(_searchQuery.toLowerCase()))
        .toList();
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
        title: _isSearching
            ? TextField(
          onChanged: (query) {
            setState(() {
              _searchQuery = query;
            });
          },
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Jaro',color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white),
          ),
        )
            : Center(child: Text('DASHBOARD',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Jaro',color: Colors.white),)),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchQuery = "";
                }
              });
            },
          ),
        ],
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
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,

                  child:
                  SafeArea(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child:
                        Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text('ALL READER',style: TextStyle(fontSize: 20,fontFamily: 'BigshotOne',color: Colors.white),),
                          SizedBox(height: 10,),
                          Row(
                            children: filteredNotifications.map((notification) {
                              return buildNotificationCard2(notification);
                            }).toList(),
                          ),

                        ],)
                      ),
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child:
                          Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ALL Writers',style: TextStyle(fontSize: 20,fontFamily: 'BigshotOne',color: Colors.white),),
                              SizedBox(height: 10,),
                              Row(
                                children:  notifications3.map((notification3) {
                                  return buildNotificationCard3(notification3);
                                }).toList(),
                              ),

                            ],)
                      ),
                    ],
                  ))),
            ),
          ],)
      ),
    );
  }
  Widget buildNotificationCard2(Map<String, dynamic> notification2) {
    final int Reader_ID = notification2['Reader_ID'] ?? '';
    final String Email = notification2['Email'] ?? '';
    final int Balance = notification2['Balance'] ?? 0;
    final String Subscription = notification2['Subscription'] ?? '';
    final String Interest = notification2['Interest'] ?? '';
    final String UserName = notification2['UserName'] ?? '';

    final String imagePath = notification2['imagePath'] ?? Image.asset('Images/DP.jpeg');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        duration:Duration(milliseconds: 500),
        height: 200,
        width: 420,
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
              width: 300,

              decoration: BoxDecoration(

                color:mateBlack,

              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: [
                    Text(
                      UserName,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Rye'
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          '  Subscription:   ',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                        Text(
                          Subscription,
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
                        Text(
                          '  Interests:',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          Interest,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
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
                          '  Balance:',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          Balance.toString(),
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




                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildNotificationCard3(Map<String, dynamic> notification3) {

    final String Email = notification3['Email'] ?? '';
    final int Balance = notification3['Balance'] ?? 0;

    final String Interest = notification3['Interest'] ?? '';
    final String UserName = notification3['UserName'] ?? '';

    final String imagePath = notification3['imagePath'] ?? '';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        duration:Duration(milliseconds: 500),
        height: 200,
        width: 420,
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
              width: 300,

              decoration: BoxDecoration(

                color:mateBlack,

              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: [
                    Text(
                      UserName,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Rye'
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          '   Interests:   ',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                        Text(
                          Interest,
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
                        Text(
                          '  Balance:',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          Balance.toString(),
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
