import 'package:flutter/material.dart';

class BalanceRequestScreen extends StatefulWidget {
  const BalanceRequestScreen({super.key});

  @override
  State<BalanceRequestScreen> createState() => _BalanceRequestScreenState();
}

class _BalanceRequestScreenState extends State<BalanceRequestScreen> {
  TextEditingController emailconut=TextEditingController();
  TextEditingController rechargecount=TextEditingController();
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
              title: Text(
                'Home',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              onTap: () {
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: Text(
                'Subscription:Free',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: Text(
                'Update Interest',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
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
              title: Text(
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
                child: Text(
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
        title: Text(
          'Balance Recharge',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: Column(
        children: [
          Center(
              child: Text(
            'Enter Ammount To Recharge',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
          TextFormField(
            controller: emailconut,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),

              hintText: 'Email',
              labelText: 'Email',
              //suffixIcon: Icon(Icons.email),
              prefixIcon: Icon(Icons.email)

            ),

          ),
          SizedBox(height: 10,),
          TextFormField(
            controller: emailconut,
            decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),

                hintText: 'Recharge Ammount',
                labelText: 'Recharge Ammount',
                //suffixIcon: Icon(Icons.email),
                prefixIcon: Icon(Icons.money)

            ),

          ),
          SizedBox(height: 10,),

          Container(height: 40,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                  color: Colors.yellow,
                  width: 2
              ),

            ),
            child: Text('Recharge',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.yellow),),
          ),
        ],
      ),
    );
  }
}
