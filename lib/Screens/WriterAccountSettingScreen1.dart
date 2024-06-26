import 'package:flutter/material.dart';

class WriterAccountSettingScreen1 extends StatefulWidget {
  const WriterAccountSettingScreen1({super.key});

  @override
  State<WriterAccountSettingScreen1> createState() =>
      _WriterAccountSettingScreenState1();
}

class _WriterAccountSettingScreenState1
    extends State<WriterAccountSettingScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account Setting',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('Images/man2.webp'),

            ),
            const SizedBox(height: 10,),
            const Text('Faizanchaudhry671@gmail.com',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

            const SizedBox(height: 30,),
            const Text('Name:Faizan Mustafa',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            const Text('Password:dj**nkdk*****',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            const Text('Balance:2000',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            const SizedBox(height: 40,),


            Container(height: 40,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                    color: Colors.yellow,
                    width: 2
                ),

              ),
              child: const Text('Recharge',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.yellow),),
            ),
          ],),
      ),
    );
  }
}
