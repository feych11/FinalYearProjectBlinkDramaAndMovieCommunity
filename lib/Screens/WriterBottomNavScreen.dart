import 'dart:convert';

import 'package:finalsemproject/API.dart';
import 'package:finalsemproject/Screens/HistoryOfWriterSentProject.dart';
import 'package:finalsemproject/Screens/ReaderLoginScreen.dart';
import 'package:finalsemproject/Screens/WriterAcceptedProjectsScreen.dart';
import 'package:finalsemproject/Screens/WriterNotificationScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
class ReaderBottomNavScreen11 extends StatefulWidget {
  const ReaderBottomNavScreen11({super.key});

  @override
  State<ReaderBottomNavScreen11> createState() => _ReaderBottomNavScreenState();
}

class _ReaderBottomNavScreenState extends State<ReaderBottomNavScreen11> {
  String? userId;
  String? WriterName;
  String? WriterBalance;
  String? WriterImage;
  int _currentIndex = 0;
   int _notificationCount=0;
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
      // getWriterNotificationsSentProject(userId.toString());
      print('ghjk:$userId');
      print('WriterName: $WriterName');
      print('Writer Balance: $WriterBalance');
      print('WriterImageL $WriterImage');
    }
  }
  Future<void> getWriterNotificationsSentProject(String writerId) async {
    try {
       const String baseurl2 =APIHandler.baseUrl1;  // Replace with your API base URL
      final response = await http.get(
        Uri.parse('$baseurl2/Writer/GetWriterNotificationsSentProject?writerId=$writerId'),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final editorNotifications = responseData['WriterNotifications'];
        final totalCount = responseData['TotalCount'];
        _notificationCount =totalCount;
        print('Total count: $totalCount');
        print("notification count $_notificationCount");
        // Process responseData as needed
        print('Writer notifications: $editorNotifications');
      } else if (response.statusCode == 404)
      {
        print('No writer notifications found for the specified writer ');
      } else {
        print('Failed to fetch writer notifications: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error fetching writer notifications: $error');
    }
  }


  final List<Widget> _pages = [
    // Replace these with your actual content widgets for each tab
    const WriterNotificationScreen(),
    const WriterAcceptedProjectsScreen1(),
    const HistoryOfWriterSentProject(),

  ];
  @override
  void initState() {
    super.initState();
    getUserIdFromSharedPreferences();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;

          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Stack(
                children: [
                  const Icon(Icons.notifications,size: 30,),
                  if(_notificationCount>0)
                    Positioned(

                      top: 0,
                      bottom: 14,
                      left: 14,

                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '$_notificationCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),),)
                ],
              ),
              label: 'Notification'
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.details),
            label: 'Details',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
                onTap: (){
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ReaderLoginScreen()));
                  });
                },
                child: const Icon(Icons.logout)),
            label: 'Logout',
          ),
          
        ],
      ),

    );
  }
}
