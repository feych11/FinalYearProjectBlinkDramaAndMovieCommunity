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
  int? movieID;
  String?movieName;
  String ?movieImage;
  String?movieType;
  List<dynamic> movieDetails = [];
  Future<void> issueFreeMovie() async {
    final String baseUrl = APIHandler.baseUrl1; // Replace with your API base URL
    final response = await http.get(Uri.parse('$baseUrl/Reader/IssueFreeMovie?readerId=${userId.toString()}'));
    try {


      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final moviedata = jsonData['Movie'];
        setState(() {
          movieDetails = [
            jsonData['Movie']['Image'],
            jsonData['Movie']['Name'],
            jsonData['Movie']['Type']
          ];
        });
        final writer = jsonData['Writer'];
        final issueDate = jsonData['issueDate'];
        final issuedMovie=jsonData['IssuedMovie'];

        // Now you can use the movie, writer, and issuedMovie data as needed
        // For example, you can display the information in your UI
        print('Movie Data: $moviedata');
        print('Movie ID: $movieDetails');
        print('Movie Name: $movieName');
        print('Movie Image: $movieImage');
        print('Movie Type: $movieType');
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
      print('Movie Image: $movieImage');
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
                              child: Image.network(movieDetails.isNotEmpty
                                  ? movieDetails[0].toString()
                                  : 'defaultImageURL')
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
