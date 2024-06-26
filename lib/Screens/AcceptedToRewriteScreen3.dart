import 'package:finalsemproject/Screens/WriterRewriteSummaryScreen.dart';
import 'package:flutter/material.dart';
class AcceptedToRewriteScreen3 extends StatefulWidget {
  String?MovieName;
  String?Editorcomments;
  String?Summary;
  int?SentprojectID;
  AcceptedToRewriteScreen3({super.key,
  this.MovieName,
    this.Editorcomments,
    this.Summary,
    this.SentprojectID
  });

  @override
  State<AcceptedToRewriteScreen3> createState() => _AcceptedToRewriteScreen3State();
}

class _AcceptedToRewriteScreen3State extends State<AcceptedToRewriteScreen3> {

  @override
  void initState() {
    super.initState();
    print('Movie name: ${widget.MovieName}');
    print("Editors comments: ${widget.Editorcomments}");
    print('Summary: ${widget.Summary}');
    print('Sent project id:: ${widget.SentprojectID}');

  }


    @override
  Widget build(BuildContext context) {
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
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Rewrite Summary',textAlign: TextAlign.start,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white,fontFamily: 'Rye'),),
      backgroundColor: Colors.black,),
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
        Card(
          elevation: 10,
          color: Colors.amber,

          child: Center(child: Text(widget.MovieName.toString(),style: const TextStyle(fontSize: 30,fontFamily: 'BigshotOne'),)),
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 300,
            width: 350,
            decoration: const BoxDecoration(
                color: Colors.black
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.Editorcomments.toString(),style: const TextStyle(fontSize: 20,fontFamily: 'BigshotOne',color: Colors.white),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10,),
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>WriterRewriteSummaryScreen(SentprojectID: widget.SentprojectID,Summary: widget.Summary,Title: widget.MovieName,)));
          },
          child: Container(height: 40,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.yellow, // Set your desired border color here
                width: 2.0, // Set the border width
              ),

            ),
            child: const Center(child: Text('REWRITE',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.yellow,fontFamily: 'BigshotOne'),)),
          ),
        )


      ],),
    );
  }
}
