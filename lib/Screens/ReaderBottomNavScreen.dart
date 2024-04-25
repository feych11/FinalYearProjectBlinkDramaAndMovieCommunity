import 'package:finalsemproject/Screens/FavouriteScreen.dart';
import 'package:finalsemproject/Screens/HistoryScreen.dart';
import 'package:finalsemproject/Screens/MoviesandDarama.dart';
import 'package:finalsemproject/Screens/ReaderHomePageScreen.dart';
import 'package:flutter/material.dart';
class ReaderBottomNavScreen extends StatefulWidget {
  const ReaderBottomNavScreen({super.key});

  @override
  State<ReaderBottomNavScreen> createState() => _ReaderBottomNavScreenState();
}

class _ReaderBottomNavScreenState extends State<ReaderBottomNavScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    // Replace these with your actual content widgets for each tab
    ReaderHomePageScreen(),
    MoviesAndDarama(),
    HistoryScreen(),
    FavouriteScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
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
            icon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
        ],
      ),

    );
  }
}
