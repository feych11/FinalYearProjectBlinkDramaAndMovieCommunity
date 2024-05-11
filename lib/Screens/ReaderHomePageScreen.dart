// import 'package:flutter/material.dart';
//
// class ReaderHomePageScreen extends StatefulWidget {
//   const ReaderHomePageScreen({super.key});
//
//   @override
//   State<ReaderHomePageScreen> createState() => _ReaderHomePageScreenState();
// }
//
// class _ReaderHomePageScreenState extends State<ReaderHomePageScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Home Page',
//           style: TextStyle(
//               fontWeight: FontWeight.bold, fontSize: 30, color: Colors.yellow),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Center(
//             child: Container(
//                 height: 450,
//                 width: 300,
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                 ),
//                 child: Row(
//                   children: [
//                     Text(
//                       'Free Daily',
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                           color: Colors.white),
//                     ),
//                     SizedBox(
//                       width: 30,
//                     ),
//                     Column(children: [
//                       Center(
//                         child: Container(
//                           height: 200,
//                           width: 100,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.all(Radius.circular(10)),
//                               color: Colors.orange),
//                           child: Image.network(
//                               'data:image/jpeg;base64,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'),
//                         ),
//                       ),
//                       SizedBox(height: 10,),
//                       Text('Hasseeb Hassan',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.yellow),),
//                       Text('PARWAZ HA JANOON',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)
//                     ],)
//                   ],
//                 ),
//
//
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
// }
import 'dart:convert';

import 'package:finalsemproject/API.dart';
import 'package:finalsemproject/Screens/ReaderBottomNavScreen.dart';
import 'package:finalsemproject/Screens/ReaderLoginScreen.dart';
import 'package:finalsemproject/Screens/ReaderSelectInterestsScreen.dart';
import 'package:finalsemproject/Screens/ReaderSubcriptionScreen.dart';
import 'package:finalsemproject/Screens/ReadingScreen.dart';
import 'package:finalsemproject/Screens/WriterAccountSettingScreen1.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReaderHomePageScreen extends StatefulWidget {
  const ReaderHomePageScreen({super.key});

  @override
  State<ReaderHomePageScreen> createState() => _ReaderHomePageScreenState();
}

class _ReaderHomePageScreenState extends State<ReaderHomePageScreen> {
  String ?userId;
  String? WriterName;
  String? WriterBalance;
  String? WriterImage;

  Future<void> issueFreeMovie() async {
    final String baseUrl = APIHandler.baseUrl1; // Replace with your API base URL
    final response = await http.get(Uri.parse('$baseUrl/Reader/IssueFreeMovie?readerId=${userId.toString()}'));
    try {


      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final movie = jsonData['Movie'];
        final writer = jsonData['Writer'];
        final issueDate = jsonData['issueDate'];
        final issuedMovie=jsonData['IssuedMovie'];

        // Now you can use the movie, writer, and issuedMovie data as needed
        // For example, you can display the information in your UI
        print('Movie: $movie');
        print('Writer: $writer');
        print('issueDate:${issueDate}');
        print('Issued Movie: $issuedMovie');
      } else {
        // Handle other status codes here
        print('Failed to issue free movie: ${response.reasonPhrase}');

      }
    } catch (e) {
      print('Error issuing free movie: $e');

    }
  }
  Future<void> getUserIdFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('Reader_ID');
    final username=prefs.getString('Username1');
   // final userbalance=prefs.getString('Balance');
    final userImage=prefs.getString('UserImage1');
    setState(() {
      userId = user;
      WriterName=username;
     // WriterBalance=userbalance;
      WriterImage=userImage;
      print('jskksd: ${userId}');
      print('WriterName: ${WriterName}');
      //print('Writer Balance: ${WriterBalance}');
      print('WriterImageL ${WriterImage}');
    });
    if (userId != null) {
      issueFreeMovie();
      // print('Getrewrtedata:${getRewriteData}');

      print('ghjk:${userId}');
      print('WriterName: ${WriterName}');
      print('Writer Balance: ${WriterBalance}');
      print('WriterImageL ${WriterImage}');
    }
  }

  @override
  void initState(){
    super.initState();
    getUserIdFromSharedPreferences();

  }
  
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Home Page'),
    //     centerTitle: true,
    //   ),
    //   body: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Container(
    //           color: Colors.black,
    //           height: 250,
    //           width: 300,
    //           child: Row(
    //             //mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: Text(
    //                   'Text Widget',
    //                   style: TextStyle(color: Colors.white),
    //                 ),
    //               ),
    //               SizedBox(width: 30,),
    //               Container(
    //                 height: 200,
    //                 width: 100,
    //                 decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(20.0),
    //                   color: Colors.white
    //                 ), // Replace with your image widget
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       Text(
    //         'Additional Text Widget 1',
    //         style: TextStyle(color: Colors.black),
    //       ),
    //       Text(
    //         'Additional Text Widget 2',
    //         style: TextStyle(color: Colors.black),
    //       ),
    //       Row(
    //        // mainAxisAlignment: MainAxisAlignment.spaceAround,
    //         children: [
    //           Icon(Icons.star, color: Colors.yellow),
    //           Icon(Icons.star, color: Colors.yellow),
    //           Icon(Icons.star, color: Colors.yellow),
    //           Icon(Icons.star, color: Colors.yellow),
    //           Icon(Icons.star, color: Colors.yellow),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
    return Scaffold(
      drawer: Drawer(
      backgroundColor: Colors.grey,
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
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Text(
                        'Faizan Mustafa',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      Text(
                        'Balance:2000',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 5,
                  ),
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
                ],
              )),

          ListTile(
            title: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ReaderBottomNavScreen()));
              },
              child: Text(
                'Home',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            onTap: () {
              // Add your action when the item is tapped
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            title: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ReaderSubcriptionScreen()));
              },
              child: Text(
                'Subscription:Free',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            onTap: () {
              // Add your action when the item is tapped
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            title: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ReaderSelectInterestsScreen()));
              },
              child: Text(
                'Update Interest',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            onTap: () {
              // Add your action when the item is tapped
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            title: Text(
              'Recharge Balance',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            onTap: () {
              // Add your action when the item is tapped
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            title: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>WriterAccountSettingScreen1()));
              },
              child: Text(
                'Account Setting',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            onTap: () {
              // Add your action when the item is tapped
              Navigator.pop(context); // Close the drawer
            },
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ReaderLoginScreen()));
            },
            child: ListTile(
              title: Container(
                height: 40,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Colors.red, width: 2),
                ),
                child: Text(
                  'LOGOUT',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.red),
                ),
              ),
            ),
          ),
          // Add more ListTiles for additional items in the drawer
        ],
      ),
    ),
      appBar: AppBar(
        title: Text(
          'Home Page',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Card(
            elevation: 5,
            color: Colors.white,
            child: Text('Discover',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(

                height: 270,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'FREE DAILY',
                            style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ReadingScreen()));
                            },
                            child: Container(
                              height: 150,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.white),
                              child: Image.asset('Images/parwaz1.jpg')
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white),
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Haseeb Hassan',
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Parwaz Hai Janoon',
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),
                            ),
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.star, color: Colors.yellow),
                                Icon(Icons.star, color: Colors.yellow),
                                Icon(Icons.star, color: Colors.yellow),
                                Icon(Icons.star, color: Colors.yellow),
                                Icon(Icons.star, color: Colors.yellow),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                elevation: 5,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Top Pick',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  color: Colors.black,
                  child: ElevatedButton(onPressed: (){},child: Text('See All',style: TextStyle(fontWeight: FontWeight.bold),),),
                ),
              ),
            ],),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              InkWell(
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ReadingScreen()));
                },
                child: Container(
                    height: 150,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white),
                    child: Column(children: [
                      Image.asset(

                          'Images/parwaz2.jpg',
                      height: 100,
                      width: 70,
                      fit: BoxFit.cover,),
                      Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,

                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text(
                          'Maula Jutt',
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Paid',
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),
                        ),]),
                      )
                    ],)
                ),
              ),
              SizedBox(width: 10,),
              InkWell(
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ReadingScreen()));
                },
                child: Container(
                    height: 150,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white),
                    child: Column(children: [
                      Image.asset(

                        'Images/Dukhtar1.png',
                        height: 100,
                        width: 70,
                        fit: BoxFit.cover,),
                      Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,

                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dukhtar',
                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Paid',
                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),
                              ),]),
                      )
                    ],)
                ),
              ),
              SizedBox(width: 10,),
              InkWell(
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ReadingScreen()));
                },
                child: Container(
                    height: 150,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white),
                    child: Column(children: [
                      Image.asset(

                        'Images/waar1.jpg',
                        height: 100,
                        width: 70,
                        fit: BoxFit.cover,),
                      Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,

                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Waar',
                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Paid',
                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),
                              ),]),
                      )
                    ],)
                ),
              ),
            ],),
          )

        ],
      ),
    );
  }
}
