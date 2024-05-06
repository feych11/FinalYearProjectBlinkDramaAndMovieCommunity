import 'dart:convert';

import 'package:finalsemproject/API.dart';
import 'package:finalsemproject/Screens/FavouriteScreen.dart';
import 'package:finalsemproject/Screens/HistoryOfWriterSentProject.dart';
import 'package:finalsemproject/Screens/HistoryScreen.dart';
import 'package:finalsemproject/Screens/MoviesandDarama.dart';
import 'package:finalsemproject/Screens/ReaderHomePageScreen.dart';
import 'package:finalsemproject/Screens/ReaderLoginScreen.dart';
import 'package:finalsemproject/Screens/WriterAcceptedProjectsScreen.dart';
import 'package:finalsemproject/Screens/WriterLoginScreen.dart';
import 'package:finalsemproject/Screens/WriterNotificationScreen.dart';
import 'package:finalsemproject/Screens/WriterWriteSummaryScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class ReaderBottomNavScreen11 extends StatefulWidget {
  const ReaderBottomNavScreen11({super.key});

  @override
  State<ReaderBottomNavScreen11> createState() => _ReaderBottomNavScreenState();
}

class _ReaderBottomNavScreenState extends State<ReaderBottomNavScreen11> {
  int _currentIndex = 0;
  int _notificationCount=3;
  Future<void> getWriterNotificationsSentProject(int writerId) async {
    try {
       const String baseurl2 =APIHandler.baseUrl1;  // Replace with your API base URL
      final response = await http.get(
        Uri.parse('$baseurl2/GetWriterNotificationsSentProject?writerId=$writerId'),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        // Process responseData as needed
        print('Writer notifications: $responseData');
      } else if (response.statusCode == 404) {
        print('No writer notifications found for the specified writer');
      } else {
        print('Failed to fetch writer notifications: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error fetching writer notifications: $error');
    }
  }


  final List<Widget> _pages = [
    // Replace these with your actual content widgets for each tab
    WriterNotificationScreen(),
    WriterAcceptedProjectsScreen1(),
    HistoryOfWriterSentProject(),

  ];
  @override
  void initState() {
    super.initState();

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
                  Icon(Icons.notifications,size: 30,),
                  if(_notificationCount>0)
                    Positioned(

                      top: 0,
                      bottom: 14,
                      left: 14,

                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '$_notificationCount',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),),)
                ],
              ),
              label: 'Notification'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.details),
            label: 'Details',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
                onTap: (){
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ReaderLoginScreen()));
                  });
                },
                child: Icon(Icons.logout)),
            label: 'Logout',
          ),
          
        ],
      ),

    );
  }
}
