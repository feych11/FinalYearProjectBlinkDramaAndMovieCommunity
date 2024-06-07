import 'package:finalsemproject/Screens/WriterAcceptedProjectsScreen.dart';
import 'package:flutter/material.dart';
class WeiterSendSummaryScreen extends StatefulWidget {
  const WeiterSendSummaryScreen({super.key});

  @override
  State<WeiterSendSummaryScreen> createState() => _WeiterSendSummaryScreenState();
}

class _WeiterSendSummaryScreenState extends State<WeiterSendSummaryScreen> {
  TextEditingController urlcont=TextEditingController();
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
              title: const Text(
                'Home',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              onTap: () {
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text(
                'Subscription:Free',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text(
                'Update Interest',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
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
              title: const Text(
                'Account Setting',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              onTap: () {
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
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
            // Add more ListTiles for additional items in the drawer
          ],
        ),
      ),
      appBar: AppBar(

        title: const Center(
          child: Text(
            'Send Summary',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.black),
          ),
        ),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          
          children: [
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            const Column(children: [
              Text('Editor Email:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Text('Chfaizan671@gmail.com',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              SizedBox(height: 7,),
              Text('Writer Name:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Text('Ahmed Zubair',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              SizedBox(height: 7,),
              Text('Movie Name:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Text('Parwaz Hai Junoon',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              SizedBox(height: 7,),
              Text('Director Name:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Text('Haseeb Hassan',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
            ],),
        
            Container(height: 150,
            width: 100,
            decoration: const BoxDecoration(
              color: Colors.black
            ),
              child: Image.asset('Images/parwaz1.jpg'),
            )
          ],),
            const SizedBox(height: 15,),
            TextFormField(controller: urlcont,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                hintText: 'URL',
                labelText: 'URL',
                prefixIcon: const Icon(Icons.link)
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.yellow, width: 2),
                borderRadius: BorderRadius.circular(10)

              ),child: Center(child: InkWell(

                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const WriterAcceptedProjectsScreen1()));
                },
                child: const Text('Send',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.yellow),))),
            )
        ],),
      ),
    );
  }
}
