import 'dart:convert';

import 'package:finalsemproject/API.dart';
import 'package:finalsemproject/Screens/EditorReadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
class EditorNotificationScreen extends StatefulWidget {
  const EditorNotificationScreen({super.key});

  @override
  State<EditorNotificationScreen> createState() => _EditorNotificationScreenState();
}

class _EditorNotificationScreenState extends State<EditorNotificationScreen> {
  List<dynamic> projects = [];
  final Color mateBlack = Color(0xFF242424);
  String ?userId;


  Future<void> getEditorId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('Editor_ID');
    setState(() {
      userId = user;
      print('EditorIDDDDDD: ${userId}');
    });
    if(userId!=null)
    {
      fetchProjects(userId.toString());
    }
  }

  Future<void> fetchProjects(String editorid) async {
    const String baseurl2 = APIHandler.baseUrl1;
    const String baseurl3 = APIHandler.baseUrl2;
    final response = await http.get(Uri.parse('$baseurl2/Editor/ReceiveSentProject?Editor_ID='+editorid));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['Project'];
      setState(() {
        // projects = json.decode(response.body)['Project'];
        print(data);
        projects = data.map((project) {
          final proposalData = project['ProposalData'];
          return {
            'id': project['Movie_ID'],
            'sentProjectID':project['SentProject_ID'],
            'sentProposalId': project['SentProposal_ID'],
            'editorId': project['Editor_ID'],
            'writerId': project['Writer_ID'],
            'Status':project['Status'],
            'title': proposalData != null ? proposalData['Movie_Name'] : '',
            'genre': proposalData != null ? proposalData['Genre'] : '',
            'director': proposalData != null ? proposalData['Director'] : '',
            'imagePath': proposalData != null ? '$baseurl3/Images/${proposalData['Image']}' : '',
            'type': proposalData != null ? proposalData['Type'] : '',
          };
        }).toList();
      });
    } else {
      throw Exception('Failed to load projects');
    }
  }
  // Future<void> updateAllEditorNotificationsToFalseSentProject(int editorId) async {
  //   try {
  //     const String baseUrl = 'http://192.168.43.218/BlinkBackend/api'; // Replace with your API base URL
  //     final response = await http.post(
  //       Uri.parse('$baseUrl/Editor/UpdateAllEditorNotificationstoFalseSentProject?editorId=$editorId'),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       print('All Editor notifications updated to false for the specified editor');
  //     } else if (response.statusCode == 404) {
  //       print('No SentProject records found for the specified editor');
  //     } else {
  //       print('Failed to update Editor notifications: ${response.reasonPhrase}');
  //     }
  //   } catch (error) {
  //     print('Error updating Editor notifications: $error');
  //   }
  // }
  @override
  void initState() {
    super.initState();

    getEditorId();
    print('Userid::: $userId');
    //updateAllEditorNotificationsToFalseSentProject(2);

  }
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

              title: Text('Subscription:Free',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              onTap: () {
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
              },

            ),
            ListTile(
              title: Text('Update Interest',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
              onTap: () {
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
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
                child: Text('LOGOUT',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.red),),
              ),
            ),
            // Add more ListTiles for additional items in the drawer
          ],
        ),

      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        // actions: [
        //   IconButton(onPressed: (){}, icon: Icon(Icons.notifications))
        // ],
        centerTitle: true,
        title: Text('Notification',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,fontFamily: 'BigshotOne',color: Colors.white),),
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
            children: projects.map((notification) {
              return buildNotificationCard(notification);
            }).toList(),
          ),
        ),],)
      ),
    );
  }
  Widget buildNotificationCard(Map<String, dynamic> notification) {
    final String id = notification['id'].toString()?? '';
    final String writerId=notification['writerId'].toString()??'';
    final String sentProjectID = notification['sentProjectID'].toString()?? '';
    final String title = notification['title'] ?? '';
    final String writerName = notification['writerId'].toString() ?? 'Unknown';
    final String director = notification['director'] ?? 'Unknown';
    final String type = notification['type'] ?? 'Unknown';
    final String Status = notification['Status'] ?? 'Unknown';
    final String imagePath = notification['imagePath'] ?? '';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: 200,
        width: 320,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: 150,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(
                imagePath,
                fit: BoxFit.cover,
              ), // Use Image.network for remote images
            ),
            SizedBox(width: 10),
            Container(
              height: 210,
              width: 200,
              decoration: BoxDecoration(color: mateBlack),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'BigshotOne'
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '  Director: $director',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white,
                          fontFamily: 'Rye'
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '  Status: $Status',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white,
                          fontFamily: 'Rye'
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '  Type: $type',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white,
                          fontFamily: 'Rye'
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: GestureDetector(
                        onTap: (){
                          print('MovieID: $id');
                          print('SENTPROJECT ID: $sentProjectID');
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>EditorReadingScreen(writerId: writerId,moviename: title,MovieID: id,sentProjectID: sentProjectID,)));
                        },
                        child: Container(
                          height: 30,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(child: Text('View',style: TextStyle(fontSize: 20,fontFamily: 'Rye',fontWeight: FontWeight.bold),)),
                        ),
                      ),
                    )
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

