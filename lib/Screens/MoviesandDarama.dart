import 'package:finalsemproject/Screens/ReaderBottomNavScreen.dart';
import 'package:finalsemproject/Screens/ReaderLoginScreen.dart';
import 'package:finalsemproject/Screens/ReaderSelectInterestsScreen.dart';
import 'package:finalsemproject/Screens/ReaderSubcriptionScreen.dart';
import 'package:finalsemproject/Screens/ReadingScreen.dart';
import 'package:finalsemproject/Screens/WriterAccountSettingScreen.dart';
import 'package:finalsemproject/Screens/WriterAccountSettingScreen1.dart';
import 'package:flutter/material.dart';

class MoviesAndDarama extends StatefulWidget {
  const MoviesAndDarama({super.key});

  @override
  State<MoviesAndDarama> createState() => _MoviesAndDaramaState();
}

class _MoviesAndDaramaState extends State<MoviesAndDarama> {
  TextEditingController searchcont=TextEditingController();
  TextEditingController categorycont=TextEditingController();
  TextEditingController typecont=TextEditingController();
  final List<String> categoriesList = ['Category','Action', 'Comedy','Horror','Fantasy', 'Drama', 'Sci-Fi', 'Thriller'];
  var seleted='Category';
  final List<String> filterList=['Movies','Darama','Latest'];
  var selectedfliter='Movies';
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
        backgroundColor: Colors.grey,
        title: Text(
          'Movies & Darama',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.black),

        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Card(
            elevation: 10,
            color: Colors.black,
            child: Center(child: Text('movies And Darama',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),)),
          ),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchcont,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),

                ),
                hintText: 'Search',
                hintStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                labelText: 'Search',
                labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Row(children: [
            Expanded(
              child: Card(elevation: 10,
              color: Colors.black,
              child: DropdownButton<String>(

                value: seleted, // Initial value
                items: categoriesList.map((e) {
                  return DropdownMenuItem<String>(
                    value: e,
                    child: Text(e,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                  );
                }).toList(),
                onChanged: ( selectedCategory) {
                  // Handle selection
                  setState(() {
                    this.seleted=selectedCategory!;
                  });
                },
              ) ,
              )

            ),
            SizedBox(width: 5,),
            Expanded(
              child: Card(elevation: 10,
              color: Colors.black,
              child: DropdownButton<String>(
                value: selectedfliter,
                items: filterList.map((e) {
                  return DropdownMenuItem<String>(
                    value: e,
                    child: Text(e,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                  );
                }).toList(),
                onChanged: (selectedfil)
                {
                  setState(() {
                    this.selectedfliter=selectedfil!;
                  });
                },

              ),
              )
            ),
          ],),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Container(
                height: 130,
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.black
                ),
                child: InkWell(
                    onTap: (){
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ReadingScreen()));
                      });
                    },
                    child: Image.asset('Images/parwaz2.jpg')),
              ),
              SizedBox(width: 20,),
              Container(
                height: 130,
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.black
                ),
                child: Image.asset('Images/Dukhtar1.png'),
              ),
            ],),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text('Maula Jatt',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              SizedBox(width: 20,),
              Text('Dukhtar',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
        
            ],),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 130,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.black
                  ),
                  child: Image.asset('Images/waar1.jpg'),
                ),
                SizedBox(width: 20,),
                Container(
                  height: 130,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.black
                  ),
                  child: Image.asset('Images/actorinlaw1.jpg'),
                ),
              ],),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Waar',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                SizedBox(width: 20,),
                Text('actor In Law',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
        
              ],),
          ),
        
          
        
        ],),
      ),
    );
  }
}
