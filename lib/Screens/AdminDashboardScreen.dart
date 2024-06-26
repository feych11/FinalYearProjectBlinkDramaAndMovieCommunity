import 'package:finalsemproject/Screens/WriterAcceptedProjectsScreen.dart';
import 'package:finalsemproject/Screens/WriterLoginScreen.dart';
import 'package:finalsemproject/Screens/WriterNotificationScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:finalsemproject/API.dart';
import 'dart:convert';


class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  List<Map<String, dynamic>> notifications = [];
  final Color mateBlack = const Color(0xFF242424);
  final Color parotgreen=const Color(0xFFADE338);
  String ?userId;
  String? ReaderName;
  String ?Subscription;
  String? ReaderBalance;
  String? ReaderImage;
  bool _isSearching = false;
  String _searchQuery = "";
  List<Map<String,dynamic>>notifications2=[];
  List<Map<String,dynamic>>notifications3=[];
  List<Map<String,dynamic>>notifications4=[];

  Future<void>FetchcompanyData()async{
    const String baseurl2=APIHandler.baseUrl1;
    const String baseurl3=APIHandler.baseUrl2;
    final url = Uri.parse('$baseurl2/Admin/ShowAllComopany');
    try{
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data= json.decode(response.body);
        setState(() {
          notifications4 = data.map((proposal) {
            return {
              'Company_ID': proposal['Company_ID'],
              'Balance': proposal['Balance'],
              'Name': proposal['Name'],
              'Email': proposal['Email'],


            };
          }).toList();
        });
      } else {
        throw Exception('Failed to load Company');
      }

    }
    catch (error) {
      print('Error fetching Company Data: $error');
    }
  }


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
    FetchcompanyData();

    //getSentProposalsIdsWithEditorNotification(2);

  }
  final int _notificationCount = 3;
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
        title: _isSearching
            ? TextField(
          onChanged: (query) {
            setState(() {
              _searchQuery = query;
            });
          },
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Jaro',color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white),
          ),
        )
            : const Center(child: Text('DASHBOARD',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Jaro',color: Colors.white),)),
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
              decoration: const BoxDecoration(
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
                          const Text('ALL READER',style: TextStyle(fontSize: 20,fontFamily: 'BigshotOne',color: Colors.white),),
                          const SizedBox(height: 10,),
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
                              const Text('ALL Writers',style: TextStyle(fontSize: 20,fontFamily: 'BigshotOne',color: Colors.white),),
                              const SizedBox(height: 10,),
                              Row(
                                children:  notifications3.map((notification3) {
                                  return buildNotificationCard3(notification3);
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
                              const Text('Company Data',style: TextStyle(fontSize: 20,fontFamily: 'BigshotOne',color: Colors.white),),
                              const SizedBox(height: 10,),
                              Row(
                                children:  notifications4.map((notification4) {
                                  return buildNotificationCard4(notification4);
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
    final int readerId = notification2['Reader_ID'] ?? '';
    final String Email = notification2['Email'] ?? '';
    final int Balance = notification2['Balance'] ?? 0;
    final String Subscription = notification2['Subscription'] ?? '';
    final String Interest = notification2['Interest'] ?? '';
    final String UserName = notification2['UserName'] ?? '';

    final String imagePath = notification2['imagePath'] ?? Image.asset('Images/DP.jpeg');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        duration:const Duration(milliseconds: 500),
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
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Rye'
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
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
                        const Text(
                          '  Interests:',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          Interest,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text(
                          '  Balance:',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          Balance.toString(),
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
        duration:const Duration(milliseconds: 500),
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
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Rye'
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
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
                        const Text(
                          '  Balance:',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          Balance.toString(),
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




                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildNotificationCard4(Map<String, dynamic> notification4) {


    final int Company_ID = notification4['Company_ID'] ?? 0;

    final String Name = notification4['Name'] ?? '';
    final int Balance = notification4['Balance'] ?? '';

    final String imagePath = notification4['Image'] ?? '';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        duration:const Duration(milliseconds: 500),
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
              duration:const Duration(milliseconds: 500),
              height: 150,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child:Text('Hr Consultant'), // Use Image.network for remote images
            ),
            const SizedBox(width: 10),
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
                      Name,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Rye'
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          '   Balance:   ',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                        Text(
                          Balance.toString(),
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
                        const Text(
                          '  Comapny ID:',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          Company_ID.toString(),
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
