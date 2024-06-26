import 'package:finalsemproject/Screens/AdminDashboardScreen.dart';
import 'package:finalsemproject/Screens/EditorBalanceRequestScreen.dart';
import 'package:finalsemproject/Screens/EditorSignupScreen.dart';
import 'package:flutter/material.dart';
class AdminBottomNavScreen extends StatefulWidget {
  const AdminBottomNavScreen({super.key});

  @override
  State<AdminBottomNavScreen> createState() => _AdminBottomNavScreenState();
}

class _AdminBottomNavScreenState extends State<AdminBottomNavScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    // Replace these with your actual content widgets for each tab

    const AdminDashboardScreen(),
    const EditorBalanceRequestScreen(),
    const EditorSignUpScreen(),


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;

          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Editor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.balance),
            label: 'Balance Request',

          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.favorite),
          //   label: 'Favourite',
          // ),
        ],
      ),

    );
  }
}
