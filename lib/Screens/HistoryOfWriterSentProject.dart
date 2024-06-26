import 'dart:convert';

import 'package:finalsemproject/API.dart';
import 'package:finalsemproject/Screens/ReaderLoginScreen.dart';
import 'package:finalsemproject/Screens/WriterAcceptedProjectsScreen.dart';
import 'package:finalsemproject/Screens/WriterNotificationScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
class HistoryOfWriterSentProject extends StatefulWidget {
  const HistoryOfWriterSentProject({super.key});

  @override
  State<HistoryOfWriterSentProject> createState() => _HistoryOfWriterSentProjectState();
}

class _HistoryOfWriterSentProjectState extends State<HistoryOfWriterSentProject> {
  List<Map<String, dynamic>> notifications = [];
  final Color mateBlack = const Color(0xFF242424);
  String? userId;
  String? WriterName;
  String? WriterBalance;
  String? WriterImage;


  Future<void> getUserIdFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('userId');
    final username=prefs.getString('UserName');
    final userbalance=prefs.getString('Balance');
    final userImage=prefs.getString('Image');
    setState(() {
      userId = user;
      WriterName=username;
      WriterBalance=userbalance;
      WriterImage=userImage;
      print('jskksd: $userId');
      print('WriterName: $WriterName');
      print('Writer Balance: $WriterBalance');
      print('WriterImageL $WriterImage');
    });
    if (userId != null) {

      // print('Getrewrtedata:${getRewriteData}');

      print('ghjk:$userId');
      print('WriterName: $WriterName');
      print('Writer Balance: $WriterBalance');
      print('WriterImageL $WriterImage');


      HistoryWriterSentproject(userId.toString());

    }
  }




  Future<void>HistoryWriterSentproject(String WriterID)async
  {
    const String Baseurl=APIHandler.baseUrl1;
    const String Baseurl1=APIHandler.baseUrl2;
    final responce=await http.get(Uri.parse('$Baseurl/Writer/HistorySentProject?Writer_ID=$WriterID'));
    try
    {
      if(responce.statusCode==200)
        {
          final List<dynamic> data = json.decode(responce.body);
          setState(() {
            notifications=data.map((project)
            {
              return
                {
                  'SentProject_ID':project['SentProject_ID'],
                  'Status':project['Status'],
                  'Send_at':project['Send_at'],
                  'MovieName':project['MovieName'],
                  'Image':'$Baseurl1/Images/${project['Image']}'

                };
            }).toList();
          });
        }
      else
        {
          throw Exception('Failed To load Writer History of Sent Project');
        }
    }
    catch(error)
    {
      print('Failed To load Writer History of Sent Project $error');
    }
  }

  @override
  void initState() {
    super.initState();
    getUserIdFromSharedPreferences();
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
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(WriterImage.toString()),

                    ),
                    const SizedBox(width: 10,),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(WriterName.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white,fontFamily: 'BigShotone'),
                        ),
                        const SizedBox(height: 20,),
                        Text(WriterBalance.toString(),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white,fontFamily: 'BigShotone'),)
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
              title: const Text('Home',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,fontFamily: 'BigShotone'),),
              onTap: () {
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(

              title: const Text('Notifiactions',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,fontFamily: 'BigShotone'),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const WriterNotificationScreen()));
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
              },

            ),
            ListTile(
              title: const Text('Accepted Project',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,fontFamily: 'BigShotone'),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const WriterAcceptedProjectsScreen1()));
                // Add your action when the item is tapped
                // Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text('Recharge Balance',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,fontFamily: 'BigShotone'),),
              onTap: () {
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text('Account Setting',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,fontFamily: 'BigShotone'),),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ReaderLoginScreen()));
                  },
                  child: const Center(
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
      appBar: AppBar(

        title: const Text('Writer History',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white,fontFamily: 'BigshotOne'),),
        backgroundColor: Colors.black,
      ),
      body:
      // Display proposals
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
            children: notifications.map((notification) {
              return buildNotificationCard(notification);
            }).toList(),
          ),
        ),
      ],)
    );
  }
  Widget buildNotificationCard(Map<String, dynamic> notification) {
    final int id = notification['SentProject_ID'] ?? '';
    final String Status = notification['Status'] ?? '';
    final String sendAt = notification['Send_at'] ?? '';
    final String MovieName = notification['MovieName'] ?? '';
    final String Images = notification['Image'] ?? '';


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
              child: Image.network(Images), // Use Image.network for remote images
            ),
            const SizedBox(width: 10),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(color: mateBlack),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: [
                    Text(
                      MovieName,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'BigshotOne'
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          '      Send At:',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                        Text(
                          "   $sendAt",
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
                          '      Status:',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "   $Status",
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

                    const SizedBox(height: 10),
                    // Row(
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: InkWell(
                    //         onTap: (){
                    //
                    //         },
                    //         child: Container(
                    //           height: 25,
                    //           width: 80,
                    //           decoration: BoxDecoration(
                    //             color: Colors.yellow,
                    //             borderRadius: BorderRadius.circular(10),
                    //           ),
                    //           child: Center(
                    //             child: Text(
                    //               'Accept',
                    //               style: TextStyle(
                    //                   fontWeight: FontWeight.bold,
                    //                   fontSize: 20,
                    //                   fontFamily: 'BigshotOne'
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: InkWell(
                    //         onTap: (){
                    //
                    //         },
                    //         child: Container(
                    //           height: 25,
                    //           width: 80,
                    //           decoration: BoxDecoration(
                    //             color: Colors.yellow,
                    //             borderRadius: BorderRadius.circular(10),
                    //           ),
                    //           child: Center(
                    //             child: Text(
                    //               'Reject',
                    //               style: TextStyle(
                    //                   fontWeight: FontWeight.bold,
                    //                   fontSize: 20,
                    //                   fontFamily: 'BigshotOne'
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
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
