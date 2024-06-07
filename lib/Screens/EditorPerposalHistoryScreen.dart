import 'package:finalsemproject/Screens/WriterAcceptedProjectsScreen.dart';
import 'package:finalsemproject/Screens/WriterLoginScreen.dart';
import 'package:finalsemproject/Screens/WriterNotificationScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:finalsemproject/API.dart';
import 'dart:convert';


class EditorPerposalHistoryScreen extends StatefulWidget {
  const EditorPerposalHistoryScreen({super.key});

  @override
  State<EditorPerposalHistoryScreen> createState() => _EditorPerposalHistoryScreenState();
}

class _EditorPerposalHistoryScreenState extends State<EditorPerposalHistoryScreen> {
  List<Map<String, dynamic>> notifications = [];
  final Color mateBlack = const Color(0xFF242424);
  final Color parotgreen=const Color(0xFFADE338);

  String? userId;
  String? WriterName;
  String? WriterBalance;
  String? WriterImage;



  Future<void> getEditorId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('Editor_ID');
    setState(() {
      userId = user;
      print('EditorIDDDDDD: $userId');
    });
    if(userId!=null)
    {
      fetchProposals(userId.toString());
    }
  }
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

  Future<void> fetchProposals(String WriterID) async {
    const String baseurl2=APIHandler.baseUrl1;
    const String baseurl3=APIHandler.baseUrl2;
    final url = Uri.parse('$baseurl2/Editor/ShowSentProposals?editorId=$WriterID');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          notifications = data.map((proposal) {
            return {
              'id': proposal['SentProposal_ID'],
              'title': proposal['Movie_Name'],
              'writerName': proposal['Write_ID'],
              'director': proposal['Director'],
              'type':proposal['Type'],
              'rating': 4,
              'imagePath': '$baseurl3/Images/${proposal['Image']}',
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
  Future<void> updateEditorNotifications(int editorId) async {
    try {
      const String baseurl2=APIHandler.baseUrl1; // Replace with your API base URL
      final response = await http.post(
        Uri.parse('$baseurl2/Editor/updateEditorNotifications/$editorId'),
      );

      if (response.statusCode == 200) {
        print('Editor notifications updated successfully');
      } else if (response.statusCode == 404) {
        print('No SentProposals found for the specified editor');
      } else {
        print('Failed to update editor notifications: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error updating editor notifications: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    getEditorId();
    updateEditorNotifications(2);
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
        title: const Text('Sent Proposal',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white,fontFamily: 'BigshotOne'),),
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
            children: notifications.map((notifications) {
              return buildNotificationCard(notifications);
            }).toList(),
          ),
        ),],)
      ),
    );
  }
  Widget buildNotificationCard(Map<String, dynamic> notification) {
    final int id = notification['id'] ?? 0;
    final String title = notification['title'] ?? '';
    final String type = notification['type'] ?? '';
    final String director = notification['director'] ?? '';
    final String status = notification['status'] ?? '';
    final int rating = notification['rating'] ?? 0;
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
                    Text(
                      title,
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
                          '  Type:   ',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Rye'
                          ),
                        ),
                        Text(
                          type,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.white,
                            fontFamily: 'Rye'
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          '  Director:',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Rye'
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          director,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Colors.white,
                            fontFamily: 'Rye'
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
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
