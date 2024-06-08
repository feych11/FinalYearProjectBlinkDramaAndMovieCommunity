import 'package:finalsemproject/Screens/WriterAcceptedProjectsScreen.dart';
import 'package:finalsemproject/Screens/WriterLoginScreen.dart';
import 'package:finalsemproject/Screens/WriterNotificationScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:finalsemproject/API.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:convert';


class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
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
      print('jskksd: $userId');
      print('ReaderName: $ReaderName');
      print('Subscription::: $Subscription');
      print('Reader Balance: $ReaderBalance');
      print('ReaderImageL $ReaderImage');
    });
    if (userId != null) {
      fetchProposals();


      // print('Getrewrtedata:${getRewriteData}');

      print('ghjk:$userId');
      print('ReaderName: $ReaderName');
      print('Reader Balance: $ReaderBalance');
      print('ReaderImageL $ReaderImage');
    }
  }

  Future<void> fetchProposals() async {
    const String baseurl2=APIHandler.baseUrl1;
    const String baseurl3=APIHandler.baseUrl2;
    final url = Uri.parse('$baseurl2/Reader/GetFavoriteDetails?Reader_ID=$userId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          notifications2 = data.map((proposal) {
            return {
              'ReaderId': proposal['ReaderId'],
              'MovieId': proposal['MovieId'],
              'WriterId': proposal['WriterId'],
              'WriterName': proposal['WriterName'],
              'MovieTitle':proposal['MovieTitle'],
              'Director': proposal['Director'],
              'imagePath': '$baseurl3/Images/${proposal['Image']}',
              'WriterRating': proposal['WriterRating'],
              'MovieRating':proposal['MovieRating'],
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
  final int _notificationCount = 3;
  @override
  Widget build(BuildContext context) {
    final filteredNotifications = notifications2
        .where((notification) =>
        notification['MovieTitle']!.toLowerCase().startsWith(_searchQuery.toLowerCase()))
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
            : const Center(child: Text('Favourite Screen',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Jaro',color: Colors.white),)),
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
                    children: [
                      Column(
                        children: filteredNotifications.map((notification) {
                          return buildNotificationCard2(notification);
                        }).toList(),
                      ),
                    ],
                  ))),
            ),
          ],)
      ),
    );
  }
  Widget buildNotificationCard2(Map<String, dynamic> notification2) {
    final int ReaderId = notification2['ReaderId'] ?? '';
    final int WriterId = notification2['WriterId'] ?? '';
    final String WriterName = notification2['WriterName'] ?? '';
    final String MovieTitle = notification2['MovieTitle'] ?? '';
    final String Director = notification2['Director'] ?? '';
    final double WriterRating = notification2['WriterRating'] ?? 0;
    final double MovieRating = notification2['MovieRating'] ?? 0;
    final String imagePath = notification2['imagePath'] ?? '';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: 200,
        width: 370,
        decoration: BoxDecoration(
          color: Colors.amber,
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
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
              width: 240,
              decoration: BoxDecoration(
                color: const Color(0xFF242424), // Using mateBlack
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        MovieTitle,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Rye',
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          '  Writer Name:   ',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Rye',
                          ),
                        ),
                        Text(
                          WriterName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.white,
                            fontFamily: 'Rye',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text(
                          '  Director:',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Rye',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          Director,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Colors.white,
                            fontFamily: 'Rye',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text(
                          '  Writer Rating:',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Rye',
                          ),
                        ),
                        const SizedBox(width: 10),
                        RatingBarIndicator(
                          rating: WriterRating,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 20.0,
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text(
                          '  Movie Rating:',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Rye',
                          ),
                        ),
                        const SizedBox(width: 10),
                        RatingBarIndicator(
                          rating: MovieRating,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 20.0,
                          direction: Axis.horizontal,
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
