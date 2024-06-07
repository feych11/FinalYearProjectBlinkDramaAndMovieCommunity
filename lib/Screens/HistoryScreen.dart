import 'package:finalsemproject/Screens/ReaderBottomNavScreen.dart';
import 'package:finalsemproject/Screens/ReaderLoginScreen.dart';
import 'package:finalsemproject/Screens/ReaderSelectInterestsScreen.dart';
import 'package:finalsemproject/Screens/ReaderSubcriptionScreen.dart';
import 'package:finalsemproject/Screens/WriterAccountSettingScreen1.dart';
import 'package:flutter/material.dart';
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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
                    const SizedBox(
                      width: 10,
                    ),
                    const Column(
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
                    const SizedBox(
                      width: 5,
                    ),
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
                  ],
                )),

            ListTile(
              title: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const ReaderBottomNavScreen()));
                },
                child: const Text(
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const ReaderSubcriptionScreen()));
                },
                child: const Text(
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const ReaderSelectInterestsScreen()));
                },
                child: const Text(
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
              title: const Text(
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const WriterAccountSettingScreen1()));
                },
                child: const Text(
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const ReaderLoginScreen()));
              },
              child: ListTile(
                title: Container(
                  height: 40,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.red, width: 2),
                  ),
                  child: const Text(
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

      appBar: AppBar(title: const Text('History',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.black),),
    centerTitle: true,
      backgroundColor: Colors.grey,
    ),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: Column(

        children: [

          Container(
            height: 200,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

              Container(
                height: 150,
                width: 100,
                decoration: BoxDecoration(color: Colors.black,
                borderRadius: BorderRadius.circular(10)
                ),
                child: Image.asset('Images/parwaz1.jpg'),
              ),
                const SizedBox(width: 10,),
                Container(
                  height: 150,
                  width: 150,
                  decoration: const BoxDecoration(color: Colors.black),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Column(children: [
                      Text('Parwaz Hai Janoon',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text(
                            'Writer Name:',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            'Ali Hamza',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Director:',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Haseeb Hassan',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Rating:',
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
                                color: Colors.yellow,
                                size: 11,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 11,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 11,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 11,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 11,
                              ),
                            ],
                          ),
                        ],
                      ),

                    ],),
                  ),
                )
            ],),
          ),
          const SizedBox(height: 10,),
          Container(
            height: 200,
            width: 300,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  height: 150,
                  width: 100,
                  decoration: BoxDecoration(color: Colors.black,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Image.asset('Images/actorinlaw1.jpg'),
                ),
                const SizedBox(width: 10,),
                Container(
                  height: 150,
                  width: 150,
                  decoration: const BoxDecoration(color: Colors.black),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Column(children: [
                      Text('Actor In Law',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text(
                            'Writer Name:',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            'Ahmed Faraz',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Director:',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Nabeel Qureshi',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Rating:',
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
                                color: Colors.yellow,
                                size: 11,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 11,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 11,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 11,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 11,
                              ),
                            ],
                          ),
                        ],
                      ),

                    ],),
                  ),
                )
              ],),
          )
      ],),
    ),
    );
  }
}
