import 'package:flutter/material.dart';
class AcceptedToRewriteScreen2 extends StatefulWidget {
  const AcceptedToRewriteScreen2({super.key});

  @override
  State<AcceptedToRewriteScreen2> createState() => _AcceptedToRewriteScreen2State();
}

class _AcceptedToRewriteScreen2State extends State<AcceptedToRewriteScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

              title: const Text('Subscription:Free',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              onTap: () {
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
              },

            ),
            ListTile(
              title: const Text('Update Interest',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
              onTap: () {
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
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
                child: const Text('LOGOUT',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.red),),
              ),
            ),
            // Add more ListTiles for additional items in the drawer
          ],
        ),
      ),
      appBar: AppBar(title: const Text('FEEDBACK',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black),),),
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: SafeArea(
            child: Row(

              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Card(
                  elevation: 10,
                  color: Colors.black,
                  child: Icon(Icons.notifications,color: Colors.white,),
                ),

              ],),
          ),
        ),
        const SizedBox(height: 10,),
        const Card(
          elevation: 10,
          color: Colors.amber,

          child: Center(child: Text('WAAR',style: TextStyle(fontSize: 30,),)),
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 300,
            width: 350,
            decoration: const BoxDecoration(
                color: Colors.grey
            ),
            child: const Text('It seems like there might be a slight misunderstanding in your question.'
                ' Waar is a Pakistani action thriller film directed by Bilal Lashari,'
                ' released in 2013. The movie revolves around the theme of terrorism '
                'and militancy in Pakistan. It depicts the efforts of Pakistani security'
                ' forces to combat terrorism and explores the challenges they face.'
                ' The film gained attention for its high production values, action sequences,'
                ' and its portrayal of real-life events. Waar was a commercial success and marked'
                ' a significant milestone in the Pakistani film industry, contributing to the revival'
                ' of cinema in the country'),
          ),
        ),
        const SizedBox(height: 10,),
        Container(height: 40,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.yellow, // Set your desired border color here
              width: 2.0, // Set the border width
            ),

          ),
          child: const Center(child: Text('Rewrite',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.yellow),)),
        )


      ],),
    );
  }
}
