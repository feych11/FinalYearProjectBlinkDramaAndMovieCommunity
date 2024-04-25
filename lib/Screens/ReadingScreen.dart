import 'package:finalsemproject/Screens/ReaderBottomNavScreen.dart';
import 'package:finalsemproject/Screens/ReaderHomePageScreen.dart';
import 'package:finalsemproject/Screens/ReaderLoginScreen.dart';
import 'package:finalsemproject/Screens/ReaderSelectInterestsScreen.dart';
import 'package:finalsemproject/Screens/ReaderSubcriptionScreen.dart';
import 'package:finalsemproject/Screens/WatchingScreen.dart';
import 'package:finalsemproject/Screens/WriterAccountSettingScreen1.dart';
import 'package:flutter/material.dart';
class ReadingScreen extends StatefulWidget {
  const ReadingScreen({super.key});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
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


        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
          Text('Reading',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.black)),
           SizedBox(width: 5,),
           InkWell(
               onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>ReaderBottomNavScreen()));
               },
               child: Icon(Icons.backspace))

           ],
        ),
      centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
         
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 350,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10)
                ), // Set your desired container color
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      // Image
                      Positioned.fill(
                        child: Image.asset(
                          'Images/waar2.jpg', // Replace with your image URL
                          fit: BoxFit.fill,
                        ),
                      ),

                      // Text in the right bottom corner
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [Positioned(
                        bottom: 8, // Adjust the bottom margin as needed
                        left: 8, // Adjust the right margin as needed
                        child: Text(
                          'WAAR',
                          style: TextStyle(
                              color: Colors.white, // Set your desired text color
                              fontSize: 16,
                              fontWeight: FontWeight.bold// Set your desired text size
                          ),
                        ),
                      ),
                          Positioned(
                            bottom: 8, // Adjust the bottom margin as needed
                            left: 8, // Adjust the right margin as needed
                            child: Text(
                              'Bilal Lashari',
                              style: TextStyle(
                                  color: Colors.yellow, // Set your desired text color
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold// Set your desired text size
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 8, // Adjust the bottom margin as needed
                            left: 8, // Adjust the right margin as needed
                            child: Text(
                              'Writer: Amman',
                              style: TextStyle(
                                  color: Colors.yellow, // Set your desired text color
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold// Set your desired text size
                              ),
                            ),
                          ),
                        ],),

                    ],
                  ),
                ),
              ),
            ),
          ),
            SizedBox(height: 10,),
            Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [Colors.black, Colors.black, Colors.yellow, Colors.yellow],
                  stops: [0.0, 0.5, 0.5, 1.0],
                ),
                borderRadius: BorderRadius.circular(20),
                
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: (){
        
                      },
                      child: Text('Read',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: (){
        
                      },
                      child: InkWell(
                          onTap: (){
                            setState(() {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>WatchingScreen()));
                            });
                          },
                          child: Text('Watch',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),))),
                )
              ],),
        
            ),
            SizedBox(height: 10,),
            Container(
              height: 400,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Waar is a Pakistani action thriller film that was'
                      ' released in 2013. Directed by Bilal Lashari, the movie revolves around the theme '
                      'of terrorism and political corruption in Pakistan. It follows the story of a retired '
                      'army officer who is drawn back into service to track dow'
                      'n a terrorist cell plotting attacks in the country.  Waar gained significant attention for its high production '
                      'values, intense action sequences, and a plot that reflects real-world issues. It was praised for its cinematography'
                      ' and became one of the highest-grossing Pakistani films at the time of its release.Waar is a Pakistani action thriller '
                      'film that was released in 2013. Directed by Bilal Lashari, the movie revolves around the theme of terrorism and political '
                      'corruption in Pakistan. It follows the story of a retired army officer who is drawn back into service to track down a terrorist'
                      ' cell plotting attacks in the country.  Waar gained significant attention for its high production values, '
                      'intense action sequences, and a plot that reflects real-world issues. It was praised for its cinematography'
                      ' and became one of the highest-grossing Pakistani films at the time of its release',style: TextStyle(fontSize: 10,color: Colors.white),),
                ),
                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Rate Writer:',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.grey,
                          size: 18,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.grey,
                          size: 18,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.grey,
                          size: 18,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.grey,
                          size: 18,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.grey,
                          size: 18,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Rate Summary:',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Row(

                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.grey,
                          size: 18,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.grey,
                          size: 18,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.grey,
                          size: 18,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.grey,
                          size: 18,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.grey,
                          size: 18,
                        ),
                      ],
                    ),
                    SizedBox(width: 10,),
                    Icon(Icons.favorite,color: Colors.red,)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],)

            )
        
        ],),
      ),
    );
  }
}
