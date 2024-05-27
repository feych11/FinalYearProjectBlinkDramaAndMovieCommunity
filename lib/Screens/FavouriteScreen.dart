import 'package:finalsemproject/Screens/WriterAcceptedProjectsScreen.dart';
import 'package:finalsemproject/Screens/WriterLoginScreen.dart';
import 'package:finalsemproject/Screens/WriterNotificationScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:finalsemproject/API.dart';
import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  List<Map<String, dynamic>> notifications = [];
  final Color mateBlack = Color(0xFF242424);
  final Color parotgreen=Color(0xFFADE338);
  String ?userId;
  String? ReaderName;
  String ?Subscription;
  String? ReaderBalance;
  String? ReaderImage;
  Future<void> getUserIdFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('Reader_ID');
    final username=prefs.getString('Username1');
    final Subscription1=prefs.getString('Subscription');
    final userbalance=prefs.getString('Balance');
    final userImage=prefs.getString('UserImage1');
    setState(() {
      userId = user;
      ReaderName=username;
      Subscription=Subscription1;
      ReaderBalance=userbalance;
      ReaderImage=userImage;
      print('jskksd: ${userId}');
      print('ReaderName: ${ReaderName}');
      print('Subscription::: $Subscription');
      print('Reader Balance: ${ReaderBalance}');
      print('ReaderImageL ${ReaderImage}');
    });
    if (userId != null) {
      fetchProposals();


      // print('Getrewrtedata:${getRewriteData}');

      print('ghjk:${userId}');
      print('ReaderName: ${ReaderName}');
      print('Reader Balance: ${ReaderBalance}');
      print('ReaderImageL ${ReaderImage}');
    }
  }

  Future<void> fetchProposals() async {
    const String baseurl2=APIHandler.baseUrl1;
    const String baseurl3=APIHandler.baseUrl2;
    final url = Uri.parse('$baseurl2/Reader/GetFavoriteDetails?Reader_ID=${userId}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          notifications = data.map((proposal) {
            return {
              'ReaderId': proposal['ReaderId'],
              'MovieId': proposal['MovieId'],
              'WriterId': proposal['WriterId'],
              'WriterName': proposal['WriterName'],
              'MovieTitle':proposal['MovieTitle'],
              'Director': proposal['Director'],
              'imagePath': '$baseurl3/Images/${proposal['Image']}',
              'WriterRating': proposal['WriterRating'],
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
    getUserIdFromSharedPreferences();

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
        title: Text('Favourite Screen',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white,fontFamily: 'BigshotOne'),),
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
    final int ReaderId = notification['ReaderId'] ?? '';
    final int WriterId = notification['WriterId'] ?? '';
    final String WriterName = notification['WriterName'] ?? '';
    final String MovieTitle = notification['MovieTitle'] ?? '';
    final String Director = notification['Director'] ?? '';
    final double WriterRating = notification['WriterRating'] ?? 0;
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
                      MovieTitle,
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
                          '  Writer Name:   ',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                        Text(
                          WriterName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
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
                          '  Director:',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          Director,
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
                          '  Writer Rating:',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          WriterRating.toString(),
                          style: TextStyle(
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
