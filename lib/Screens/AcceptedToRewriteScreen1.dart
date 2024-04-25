import 'package:flutter/material.dart';
class AcceptedToRewriteScreen1 extends StatefulWidget {
  const AcceptedToRewriteScreen1({super.key});

  @override
  State<AcceptedToRewriteScreen1> createState() => _AcceptedToRewriteScreen1State();
}

class _AcceptedToRewriteScreen1State extends State<AcceptedToRewriteScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

              title: Text('Subscription:Free',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              onTap: () {
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
              },

            ),
            ListTile(
              title: Text('Update Interest',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
              onTap: () {
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
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
                child: Text('LOGOUT',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.red),),
              ),
            ),
            // Add more ListTiles for additional items in the drawer
          ],
        ),
      ),
      appBar: AppBar(title: Text('Pending Project',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Card(
                    elevation: 10,
                    color: Colors.black,
                    child: Icon(Icons.notifications,color: Colors.white,),
                  )
                ],),
            ),
            SizedBox(height: 10,),
            Container(
              height: 200,
              width: 320,
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
                  SizedBox(width: 10,),
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(color: Colors.black),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
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
                        Row(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(height: 25,
                              width: 170,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),

                              ),child: Center(child: Text('Write Summary',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                            ),
                          ),

                        ],)

                      ],),
                    ),

                  )
                ],),
            ),
            SizedBox(height: 10,),
            Container(
              height: 200,
              width: 320,
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
                    child: Image.asset('Images/waar1.jpg'),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(color: Colors.black),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
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
                        Row(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(height: 25,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),

                              ),child: Center(child: Text('Write',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                            ),
                          ),
                          Container(height: 25,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(10),

                            ),child: Center(child: Text('Comments',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                          ),
                        ],)

                      ],),
                    ),

                  )
                ],),
            ),

          ],
        ),
      ),
    );
  }
}
