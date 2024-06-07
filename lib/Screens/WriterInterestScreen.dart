import 'package:finalsemproject/Screens/WriterAcceptedProjectsScreen.dart';
import 'package:flutter/material.dart';
class WriterInterestScreen extends StatefulWidget {
  const WriterInterestScreen({super.key});

  @override
  State<WriterInterestScreen> createState() => _WriterInterestScreenState();
}

class _WriterInterestScreenState extends State<WriterInterestScreen> {
  bool checked=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Select Inetrests',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Checkbox(value: checked, onChanged: ( value)
              {
                setState(() {
                  checked=value!;
                });
              }),
              const Text('Horror',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              Checkbox(value: checked, onChanged: ( value)
              {
                setState(() {
                  checked=value!;
                });
              }),
              const Text('Fantasy',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              Checkbox(value: checked, onChanged: ( value)
              {
                setState(() {
                  checked=value!;
                });
              }),
              const Text('Action',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              Checkbox(value: checked, onChanged: ( value)
              {
                setState(() {
                  checked=value!;
                });
              }),
              const Text('Comedy',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              Checkbox(value: checked, onChanged: ( value)
              {
                setState(() {
                  checked=value!;
                });
              }),
              const Text('Sci-Fi',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              Checkbox(value: checked, onChanged: ( value)
              {
                setState(() {
                  checked=value!;
                });
              }),
              const Text('Darama',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              Checkbox(value: checked, onChanged: ( value)
              {
                setState(() {
                  checked=value!;
                });
              }),
              const Text('Thriller',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              Checkbox(value: checked, onChanged: ( value)
              {
                setState(() {
                  checked=value!;
                });
              }),
              const Text('Crime',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              Checkbox(value: checked, onChanged: ( value)
              {
                setState(() {
                  checked=value!;
                });
              }),
              const Text('Romantic',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              Checkbox(value: checked, onChanged: ( value)
              {
                setState(() {
                  checked=value!;
                });
              }),
              const Text('Animation',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              Checkbox(value: checked, onChanged: ( value)
              {
                setState(() {
                  checked=value!;
                });
              }),
              const Text('Historical',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              const SizedBox(height: 30,),
              Center(
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const WriterAcceptedProjectsScreen1()));
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Center(child: Text('SUBMIT',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white))),
                    ),
                  )
              ),


            ],),
        ),
      ),

    );
  }
}
