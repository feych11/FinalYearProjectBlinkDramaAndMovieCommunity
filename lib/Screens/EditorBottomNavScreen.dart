import 'dart:convert';

import 'package:finalsemproject/API.dart';
import 'package:finalsemproject/Screens/EditorAcceptedProjectHistoryScreen.dart';
import 'package:finalsemproject/Screens/EditorNotificationScreen.dart';
import 'package:finalsemproject/Screens/EditorPerposalHistoryScreen.dart';
import 'package:finalsemproject/Screens/EditorReadingScreen.dart';
import 'package:finalsemproject/Screens/ReaderLoginScreen.dart';
import 'package:finalsemproject/Screens/SendPerposal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class EditorBottomNavScreen extends StatefulWidget {
  const EditorBottomNavScreen({super.key});

  @override
  State<EditorBottomNavScreen> createState() => _EditorBottomNavScreenState();
}
int _notificationCount=0;
class _EditorBottomNavScreenState extends State<EditorBottomNavScreen> {
  int _currentIndex = 0;

  Future<void> getEditorNotificationsSentProject(int editorId) async {
    try {
      const String baseurl2=APIHandler.baseUrl1;// Replace with your API base URL
      final response = await http.get(
        Uri.parse('$baseurl2/Editor/getEditorNotificationsSentProject?editorId=$editorId'),
      );

      if (response.statusCode == 200) {
        // Parse the response data
        final responseData = json.decode(response.body);
        // Access the editor notifications and total count
        final editorNotifications = responseData['EditorNotifications'];
        final totalCount = responseData['TotalCount'];
        _notificationCount =totalCount;
        // Handle the editor notifications here
        print('Editor notifications: $editorNotifications');
        print('Total count: $totalCount');
        print("notification count $_notificationCount");
      } else if (response.statusCode == 404) {
        print('No editor notifications found for the specified editor');
      } else {
        print('Failed to fetch editor notifications: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error fetching editor notifications: $error');
    }
  }
  Future<void> updateAllEditorNotificationsToFalseSentProject(int editorId) async {
    try {
      const String baseUrl = 'http://192.168.43.218/BlinkBackend/api'; // Replace with your API base URL
      final response = await http.post(
        Uri.parse('$baseUrl/Editor/UpdateAllEditorNotificationstoFalseSentProject?editorId=$editorId'),
      );

      if (response.statusCode == 200) {
        print('All Editor notifications updated to false for the specified editor');
      } else if (response.statusCode == 404) {
        print('No SentProject records found for the specified editor');
      } else {
        print('Failed to update Editor notifications: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error updating Editor notifications: $error');
    }
  }


  Future<void> getSentProposalsIdsWithEditorNotification(int editorId) async {
    try {
      const String baseurl2=APIHandler.baseUrl1; // Replace with your API base URL
      final response = await http.get(
        Uri.parse('$baseurl2/Editor/getSentProposalsIdsWithEditorNotification?editorId=$editorId'),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        // Process responseData as needed
        print('Sent proposals with editor notification fetched successfully');
      } else if (response.statusCode == 404) {
        print('No SentProposals found with Editor_Notification true for the specified editor');
      } else {
        print('Failed to fetch sent proposals with editor notification: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error fetching sent proposals with editor notification: $error');
    }
  }
  final List<Widget> _pages = [
    // Replace these with your actual content widgets for each tab
    SendPerposal(),
    EditorNotificationScreen(),
    EditorPerposalHistoryScreen(),
    EditorAcceptedProjectHistoryScreen()


  ];
  @override
  void initState() {
    super.initState();
    getSentProposalsIdsWithEditorNotification(2);
    getEditorNotificationsSentProject(2);

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
            icon: Icon(Icons.home,color: Colors.white,),
            label: 'Home',


          ),
          BottomNavigationBarItem(
            // icon: Icon(Icons.details,color: Colors.white,),
            // label: 'Details',
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
            icon: Icon(Icons.history,color: Colors.white,),
            label: 'History',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_add,color: Colors.white,),
            label: 'Acc Projects',

          ),
          // BottomNavigationBarItem(
          //   icon: InkWell(
          //       onTap: (){
          //         setState(() {
          //           Navigator.push(context, MaterialPageRoute(builder: (context)=>ReaderLoginScreen()));
          //         });
          //       },
          //       child: Icon(Icons.logout,color: Colors.white,)),
          //   label: 'Logout',
          // ),

        ],
      ),

    );
  }
}
