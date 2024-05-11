import 'package:finalsemproject/API.dart';
import 'package:finalsemproject/Screens/WriterLoginScreen.dart';
import 'package:finalsemproject/Screens/WriterNotificationScreen.dart';
import 'package:finalsemproject/Screens/WriterWriteSummaryScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WriterAcceptedProjectsScreen1 extends StatefulWidget {
  const WriterAcceptedProjectsScreen1({super.key});

  @override
  State<WriterAcceptedProjectsScreen1> createState() => _WriterAcceptedProjectsScreen1State();
}

class _WriterAcceptedProjectsScreen1State extends State<WriterAcceptedProjectsScreen1> {
  List<Map<String, dynamic>> notifications = [];
  final Color mateBlack = Color(0xFF242424);
  String? userId;
  String? WriterName;
  String? WriterBalance;
  String? WriterImage;


  @override
  void initState() {
    super.initState();
    getUserIdFromSharedPreferences();
  }


  Future<void> getUserIdFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    final user = prefs.getString('userId');
    final username=prefs.getString('UserName');
    final userbalance=prefs.getString('Balance');
    final userImage=prefs.getString('Image');
    setState(() {
      userId = user;
      userId = user;
      WriterName=username;
      WriterBalance=userbalance;
      WriterImage=userImage;
      print('jskksd: ${userId}');
      print('WriterName: ${WriterName}');
      print('Writer Balance: ${WriterBalance}');
      print('WriterImageL ${WriterImage}');
    });
    if (userId != null) {
      fetchProposals();
      print('ghjk:${userId}');
      print('WriterName: ${WriterName}');
      print('Writer Balance: ${WriterBalance}');
      print('WriterImageL ${WriterImage}');
    }
  }

  Future<void> fetchProposals() async {
    const String baseurl2=APIHandler.baseUrl1;
    const String baseurl3=APIHandler.baseUrl2;
    final url = Uri.parse('$baseurl2/Writer/AcceptedProposals?Writer_ID=${userId}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          notifications = data.map((proposal) {
            return {
              'id': proposal['ID'],
              'title': proposal['Movie_Name'],
              'writerName': proposal['Write_ID'],
              'director': proposal['Director'],
              'Editor_ID': proposal['Editor_ID'],
              'Movie_ID': proposal['Movie_ID'],
              'rating': 4,
              'Type':proposal['Type'],
              'Episode':proposal['Episode'],
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(WriterImage.toString()),

                    ),
                    SizedBox(width: 10,),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(WriterName.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white,fontFamily: 'BigShotone'),
                        ),
                        SizedBox(height: 20,),
                        Text(WriterBalance.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white,fontFamily: 'BigShotone'),)
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
              title: Text('Home',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,fontFamily: 'BigShotone'),),
              onTap: () {
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(

              title: Text('Notifiactions',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,fontFamily: 'BigShotone'),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>WriterNotificationScreen()));
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
              },

            ),
            ListTile(
              title: Text('Accepted Project',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,fontFamily: 'BigShotone'),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>WriterAcceptedProjectsScreen1()));
                // Add your action when the item is tapped
                // Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: Text('Recharge Balance',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,fontFamily: 'BigShotone'),),
              onTap: () {
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: Text('Account Setting',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,fontFamily: 'BigShotone'),),
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
                  borderRadius: BorderRadius.circular(10),
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
                  child: Center(
                    child: Text
                      ('LOGOUT',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.red,fontFamily: 'BigShotone'),),
                  ),
                ),
              ),
            ),
            // Add more ListTiles for additional items in the drawer
          ],
        ),
      ),
      appBar: AppBar(title: Text('ACCEPTED PROPOSALS',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white,fontFamily: 'BigshotOne'),),
      backgroundColor: Colors.black,
      ),
      body:SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: notifications.map((notification) {
              return buildNotificationCard(notification);
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget buildNotificationCard(Map<String, dynamic> notification) {
    final int id = notification['id'] ?? '';
    final String title = notification['title'] ?? '';
    final String Writer_ID = userId ?? '';
    final String writerName = notification['writerName'] ?? '';
    final String director = notification['director'] ?? '';
    final int Movie_ID = notification['Movie_ID'] ?? '';
    final String Type = notification['Type'] ?? '';
    final int episode = notification['Episode'] ?? '';
    final String status = notification['status'] ?? '';
    final int Editor_ID = notification['Editor_ID'] ?? '';
    final int rating = notification['rating'] ?? 0;
    final String imagePath = notification['imagePath'] ?? '';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        width: 320,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(imagePath), // Use Image.network for remote images
            ),
            SizedBox(width: 10),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(color: mateBlack),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'BigshotOne'
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          'Writer Name:',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Rye'
                          ),
                        ),
                        Text(
                          writerName,
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
                          'Director:',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Rye'
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          director,
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
                          'Rating:',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                        SizedBox(width: 6),
                        Row(
                          children: List.generate(
                            rating,
                                (index) => Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              var data={id:id,
                                title: title,
                                Writer_ID:userId,
                                imagePath:imagePath,
                                Editor_ID:Editor_ID,
                              Type:Type
                              };

                              print(data);
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>WriterAcceptedProjectScreen(id:id,
                                  title: title,
                                  Writer_ID:userId,
                                  Movie_ID:Movie_ID,
                                  imagePath:imagePath,
                                  Editor_ID:Editor_ID,
                                  Episode:episode,
                              Type: Type,)));
                            });
                          },
                          child: Container(height: 25,
                            width: 180,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10),

                            ),child: Center(child: Text(' Write Summary',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontFamily: 'BigshotOne'),)),
                          ),
                        ),
                      ),

                    ],)
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
