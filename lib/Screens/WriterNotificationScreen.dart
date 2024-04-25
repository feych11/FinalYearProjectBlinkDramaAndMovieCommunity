import 'dart:convert';
import 'package:finalsemproject/API.dart';
import 'package:finalsemproject/Screens/WriterAcceptedProjectsScreen.dart';
import 'package:finalsemproject/Screens/WriterLoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class WriterNotificationScreen extends StatefulWidget {
  const WriterNotificationScreen({Key? key}) : super(key: key);

  @override
  State<WriterNotificationScreen> createState() => _WriterNotificationScreenState();
}

class _WriterNotificationScreenState extends State<WriterNotificationScreen> {
  List<Map<String, dynamic>> notifications = [];
  final Color mateBlack = Color(0xFF242424);
  String? userId;

  @override
  void initState() {
    super.initState();
    getUserIdFromSharedPreferences();


    //getEditorNotificationsSentProject(2);
    //int userID=int.parse(userId!);
    //getSentProposalIdsWithWriterNotification(userID);
    //updateAllWriterNotificationsToFalse(userID);
  }

  // Future<void> updateAllWriterNotificationsToFalse(int writerId) async {
  //   try {
  //     const String baseurl2 = APIHandler.baseUrl1; // Replace with your API base URL
  //     final response = await http.post(
  //       Uri.parse('$baseurl2/Writer/UpdateAllWriterNotificationstoFalse/$writerId'),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       print('All Writer notifications updated successfully');
  //     } else if (response.statusCode == 404) {
  //       print('No SentProposals found for the specified writer');
  //     } else {
  //       print('Failed to update all writer notifications: ${response.reasonPhrase}');
  //     }
  //   } catch (error) {
  //     print('Error updating all writer notifications: $error');
  //   }
  // }
  //
  // Future<void> getSentProposalIdsWithWriterNotification(int writerId) async {
  //   try {
  //      const String baseurl2 = APIHandler.baseUrl1;// Replace with your API base URL
  //     final response = await http.get(
  //       Uri.parse('$baseurl2/Writer/GetSentProposalsIdsWithWriterNotification/$writerId'),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final responseData = json.decode(response.body);
  //       // Handle the response data as per your requirement
  //       print('Sent proposal IDs with writer notification: $responseData');
  //     } else if (response.statusCode == 404) {
  //       print('No SentProposals found with Writer_Notification true for the specified writer');
  //     } else {
  //       print('Failed to fetch sent proposal IDs with writer notification: ${response.reasonPhrase}');
  //     }
  //   } catch (error) {
  //     print('Error fetching sent proposal IDs with writer notification: $error');
  //   }
  // }







  Future<void> getUserIdFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('userId');
    setState(() {
      userId = user;
      print('jskksd: ${userId}');
    });
    if (userId != null) {
      fetchProposals();
      print('ghjk:${userId}');
    }
  }

  Future<void> fetchProposals() async {
    const String baseurl2=APIHandler.baseUrl1;
    const String baseurl3=APIHandler.baseUrl2;
    final url = Uri.parse('$baseurl2/Writer/ShowProposals?Writer_ID=${userId}');
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
  Future<void> acceptProposal(String sentProposalId) async {
    const String baseurl2=APIHandler.baseUrl1;
    final Uri uri = Uri.parse('$baseurl2/Writer/AcceptProposal?SentProposals_ID='+sentProposalId);

    try {
      final http.Response response = await http.post(
        uri,
      );

      if (response.statusCode == 200) {
        // Proposal accepted successfully
        print('Proposal Accepted');
      } else if (response.statusCode == 404) {
        // Proposal not found
        print('Proposal not found');
      } else {
        // Other error
        print('Error: ${response.body}');
      }
    } catch (error) {
      // Error occurred during the request
      print('Error: $error');
    }
  }
  Future<void> rejectProposal(String sentProposalId) async {
    const String baseurl2=APIHandler.baseUrl1;
    final Uri uri = Uri.parse('$baseurl2/Writer/RejectProposal?SentProposals_ID='+sentProposalId);

    try {
      final http.Response response = await http.post(
        uri,
      );

      if (response.statusCode == 200) {
        // Proposal accepted successfully
        print('Proposal Rejected');
      } else if (response.statusCode == 404) {
        // Proposal not found
        print('Proposal not found');
      } else {
        // Other error
        print('Error: ${response.body}');
      }
    } catch (error) {
      // Error occurred during the request
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

        title: Text('NOTIFICATIONS',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white,fontFamily: 'BigshotOne'),),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey,
      body: SafeArea(
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
    final String writerName = notification['writerName'] ?? '';
    final String director = notification['director'] ?? '';
    final String status = notification['status'] ?? '';
    final int rating = notification['rating'] ?? 0;
    final String imagePath = notification['imagePath'] ?? '';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        width: 320,
        decoration: BoxDecoration(
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
                    SizedBox(height: 10),
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
                    SizedBox(height: 10),
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
                    SizedBox(height: 10),
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
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                             setState(() {
                               String myString = id.toString();
                               if(myString.isNotEmpty){
                                 acceptProposal(myString);
                                 fetchProposals();
                                 print(myString);
                               }
                               else{
                                 print("Empty ID");
                               }

                             });
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
                              setState(() {
                                String myString = id.toString();
                                if(myString.isNotEmpty){
                                  rejectProposal(myString);
                                  fetchProposals();
                                  print(myString);
                                }
                                else{
                                  print("Empty ID");
                                }

                              });
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

// import 'package:finalsemproject/Screens/WriterAccountSettingScreen.dart';
// import 'package:finalsemproject/Screens/WriterWriteSummaryScreen.dart';
// import 'package:flutter/material.dart';
//
// class WriterNotificationScreen extends StatefulWidget {
//   const WriterNotificationScreen({super.key});
//
//   @override
//   State<WriterNotificationScreen> createState() =>
//       _WriterNotificationScreenState();
// }
//
// class _WriterNotificationScreenState extends State<WriterNotificationScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: Drawer(
//         backgroundColor: Colors.grey,
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CircleAvatar(
//                       radius: 30,
//                       backgroundImage: AssetImage('Images/man2.webp'),
//
//                     ),
//                     SizedBox(width: 10,),
//                     Column(children: [
//                       Text('Ahmed Zubair',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),
//                       ),
//                       Text('Balance:2000',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)
//                     ],),
//                     SizedBox(width: 5,),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context); // Close the drawer
//                       },
//                       child: Icon(
//                         Icons.close,
//                         color: Colors.white,
//                         size: 30,
//                       ),
//                     ),
//                   ],)
//             ),
//
//             ListTile(
//               title: Text('Home',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
//               onTap: () {
//                 // Add your action when the item is tapped
//                 Navigator.pop(context); // Close the drawer
//               },
//             ),
//             ListTile(
//
//               title: Row(
//                 children: [
//                   Text(
//                     'Rating:',
//                     style: TextStyle(
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                   ),
//                   SizedBox(
//                     width: 6,
//                   ),
//                   Row(
//                     //mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Icon(
//                         Icons.star,
//                         color: Colors.yellow,
//                         size: 18,
//                       ),
//                       Icon(
//                         Icons.star,
//                         color: Colors.yellow,
//                         size: 18,
//                       ),
//                       Icon(
//                         Icons.star,
//                         color: Colors.yellow,
//                         size: 18,
//                       ),
//                       Icon(
//                         Icons.star,
//                         color: Colors.yellow,
//                         size: 18,
//                       ),
//                       Icon(
//                         Icons.star,
//                         color: Colors.yellow,
//                         size: 18,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               onTap: () {
//                 // Add your action when the item is tapped
//                 Navigator.pop(context); // Close the drawer
//               },
//
//             ),
//             ListTile(
//               title: Text('Interest',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
//               onTap: () {
//                 // Add your action when the item is tapped
//                 Navigator.pop(context); // Close the drawer
//               },
//             ),
//
//             ListTile(
//               title: Text('Account Setting',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
//               onTap: () {
//                 // Add your action when the item is tapped
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>WriterAccountSettingScreen())); // Close the drawer
//               },
//             ),
//             ListTile(
//               title: Container(height: 40,
//                 width: 50,
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   border: Border.all(
//                       color: Colors.red,
//                       width: 2
//                   ),
//
//                 ),
//                 child: Text('LOGOUT',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.red),),
//               ),
//             ),
//             // Add more ListTiles for additional items in the drawer
//           ],
//         ),
//       ),
//       appBar: AppBar(title: Text('Notification',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
//         backgroundColor: Colors.grey,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//
//                     Card(
//                       elevation: 10,
//                       color: Colors.black,
//                       child: InkWell(
//                           onTap: (){
//                             Navigator.pop(context);
//                           },
//                           child: Icon(Icons.notifications,color: Colors.yellow,)),
//                     )
//                   ],),
//               ),
//               SizedBox(height: 10,),
//               Container(
//                 height: 200,
//                 width: 320,
//                 decoration: BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.circular(10)
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//
//                     Container(
//                       height: 150,
//                       width: 100,
//                       decoration: BoxDecoration(color: Colors.black,
//                           borderRadius: BorderRadius.circular(10)
//                       ),
//                       child: Image.asset('Images/parwaz1.jpg'),
//                     ),
//                     SizedBox(width: 10,),
//                     Container(
//                       height: 200,
//                       width: 200,
//                       decoration: BoxDecoration(color: Colors.black),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 30),
//                         child: Column(children: [
//                           Text('Parwaz Hai Janoon',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white),
//                           ),
//                           SizedBox(height: 10,),
//                           Row(
//                             children: [
//                               Text(
//                                 'Writer Name:',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white),
//                               ),
//                               Text(
//                                 'Ali Hamza',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 10,
//                                     color: Colors.white),
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 'Director:',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white),
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Text(
//                                 'Haseeb Hassan',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 10,
//                                     color: Colors.white),
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 'Rating:',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white),
//                               ),
//                               SizedBox(
//                                 width: 6,
//                               ),
//                               Row(
//                                 //mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Icon(
//                                     Icons.star,
//                                     color: Colors.yellow,
//                                     size: 11,
//                                   ),
//                                   Icon(
//                                     Icons.star,
//                                     color: Colors.yellow,
//                                     size: 11,
//                                   ),
//                                   Icon(
//                                     Icons.star,
//                                     color: Colors.yellow,
//                                     size: 11,
//                                   ),
//                                   Icon(
//                                     Icons.star,
//                                     color: Colors.yellow,
//                                     size: 11,
//                                   ),
//                                   Icon(
//                                     Icons.star,
//                                     color: Colors.yellow,
//                                     size: 11,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           Row(children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: InkWell(
//                                 onTap: (){
//                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>WriterAcceptedProjectScreen()));
//                                 },
//                                 child: Container(height: 25,
//                                   width: 70,
//                                   decoration: BoxDecoration(
//                                     color: Colors.green,
//                                     borderRadius: BorderRadius.circular(10),
//
//                                   ),child: Center(child: Text('Accept',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
//                                 ),
//                               ),
//                             ),
//                             Container(height: 25,
//                               width: 70,
//                               decoration: BoxDecoration(
//                                 color: Colors.red,
//                                 borderRadius: BorderRadius.circular(10),
//
//                               ),child: Center(child: Text('Reject',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
//                             ),
//                           ],)
//
//                         ],),
//                       ),
//
//                     )
//                   ],),
//               ),
//               SizedBox(height: 10,),
//               Container(
//                 height: 200,
//                 width: 320,
//                 decoration: BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.circular(10)
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//
//                     Container(
//                       height: 150,
//                       width: 100,
//                       decoration: BoxDecoration(color: Colors.black,
//                           borderRadius: BorderRadius.circular(10)
//                       ),
//                       child: Image.asset('Images/waar1.jpg'),
//                     ),
//                     SizedBox(width: 10,),
//                     Container(
//                       height: 200,
//                       width: 200,
//                       decoration: BoxDecoration(color: Colors.black),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 30),
//                         child: Column(children: [
//                           Text('Parwaz Hai Janoon',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white),
//                           ),
//                           SizedBox(height: 10,),
//                           Row(
//                             children: [
//                               Text(
//                                 'Writer Name:',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white),
//                               ),
//                               Text(
//                                 'Ali Hamza',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 10,
//                                     color: Colors.white),
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 'Director:',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white),
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Text(
//                                 'Haseeb Hassan',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 10,
//                                     color: Colors.white),
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 'Rating:',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white),
//                               ),
//                               SizedBox(
//                                 width: 6,
//                               ),
//                               Row(
//                                 //mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Icon(
//                                     Icons.star,
//                                     color: Colors.yellow,
//                                     size: 11,
//                                   ),
//                                   Icon(
//                                     Icons.star,
//                                     color: Colors.yellow,
//                                     size: 11,
//                                   ),
//                                   Icon(
//                                     Icons.star,
//                                     color: Colors.yellow,
//                                     size: 11,
//                                   ),
//                                   Icon(
//                                     Icons.star,
//                                     color: Colors.yellow,
//                                     size: 11,
//                                   ),
//                                   Icon(
//                                     Icons.star,
//                                     color: Colors.yellow,
//                                     size: 11,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           Row(children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(height: 25,
//                                 width: 70,
//                                 decoration: BoxDecoration(
//                                   color: Colors.green,
//                                   borderRadius: BorderRadius.circular(10),
//
//                                 ),child: Center(child: Text('Accept',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
//                               ),
//                             ),
//                             Container(height: 25,
//                               width: 70,
//                               decoration: BoxDecoration(
//                                 color: Colors.red,
//                                 borderRadius: BorderRadius.circular(10),
//
//                               ),child: Center(child: Text('Reject',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
//                             ),
//                           ],)
//
//                         ],),
//                       ),
//
//                     )
//                   ],),
//               ),
//               SizedBox(height: 10,),
//               Container(
//                 height: 200,
//                 width: 320,
//                 decoration: BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.circular(10)
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//
//                     Container(
//                       height: 150,
//                       width: 100,
//                       decoration: BoxDecoration(color: Colors.black,
//                           borderRadius: BorderRadius.circular(10)
//                       ),
//                       child: Image.asset('Images/actorinlaw1.jpg'),
//                     ),
//                     SizedBox(width: 10,),
//                     Container(
//                       height: 200,
//                       width: 200,
//                       decoration: BoxDecoration(color: Colors.black),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 30),
//                         child: Column(children: [
//                           Text('Parwaz Hai Janoon',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white),
//                           ),
//                           SizedBox(height: 10,),
//                           Row(
//                             children: [
//                               Text(
//                                 'Writer Name:',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white),
//                               ),
//                               Text(
//                                 'Ali Hamza',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 10,
//                                     color: Colors.white),
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 'Director:',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white),
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Text(
//                                 'Haseeb Hassan',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 10,
//                                     color: Colors.white),
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 'Rating:',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white),
//                               ),
//                               SizedBox(
//                                 width: 6,
//                               ),
//                               Row(
//                                 //mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Icon(
//                                     Icons.star,
//                                     color: Colors.yellow,
//                                     size: 11,
//                                   ),
//                                   Icon(
//                                     Icons.star,
//                                     color: Colors.yellow,
//                                     size: 11,
//                                   ),
//                                   Icon(
//                                     Icons.star,
//                                     color: Colors.yellow,
//                                     size: 11,
//                                   ),
//                                   Icon(
//                                     Icons.star,
//                                     color: Colors.yellow,
//                                     size: 11,
//                                   ),
//                                   Icon(
//                                     Icons.star,
//                                     color: Colors.yellow,
//                                     size: 11,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           Row(children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(height: 25,
//                                 width: 170,
//                                 decoration: BoxDecoration(
//                                   color: Colors.yellow,
//                                   borderRadius: BorderRadius.circular(10),
//
//                                 ),child: Center(child: Text('Status:Accepted',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
//                               ),
//                             ),
//
//                           ],)
//
//                         ],),
//                       ),
//
//                     )
//                   ],),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
