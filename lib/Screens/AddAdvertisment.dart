import 'dart:convert';
import 'package:finalsemproject/API.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finalsemproject/API.dart';

class Adver{

  String ?url;
  Adver({required this.url});
}
class AddAddvertisment extends StatefulWidget {
  const AddAddvertisment({super.key});

  @override
  State<AddAddvertisment> createState() => _AddAddvertismentState();
}

class _AddAddvertismentState extends State<AddAddvertisment> {
  TextEditingController AddCon=TextEditingController();
  List<Adver>Adverlis=[];
  List<String>Advertismentlist=[];
  final Color Green  = const Color(0xFF4FAA6D);

  Future<void>AddAdvertisementindb(
     String id,
     String clips,)

  async {
  const String baseUrl2 = APIHandler.baseUrl1; // Replace with your API base URL
  final response = await http.post(Uri.parse('$baseUrl2/Admin/AddAdvertisement?CompanyID=$id&List1=$clips')); // Replace with your API endpoint

  try
  {

  final Map<String, dynamic> data = {
  'CompanyID': id,
  'List1': clips, // Pass the clips directly
  };
  print('DataAAAAAA: $data');

  body: jsonEncode(data);


  if (response.statusCode == 200) {
  // Project sent successfully
  print('Responce: ${response.body}');
  showDialog(
  context: context,
  builder: (BuildContext context) {
  return
    AlertDialog(
  backgroundColor: Green,
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(10),
  ),
  title: const Text('Sent Project',style: TextStyle(fontFamily: 'BigShotone',fontSize: 20,color: Colors.white,),),
  content: const Row(
  children: [
  Icon(Icons.check, color: Colors.black,size: 30,),
  SizedBox(width: 8),
  Text('SENT\nSUCCESSFULLY',style: TextStyle(fontFamily: 'BigShotone',fontSize: 20,color: Colors.white,),),
  ],
  ),
  actions: <Widget>[
  TextButton(
  onPressed: () {
  setState(() {
  Navigator.of(context).pop();
  });
  },
  child: const Text('OK',style: TextStyle(fontFamily: 'BigShotone',fontSize: 20,color: Colors.white,),),
  ),
  ],
  );
  },
  );
  // Handle navigation or UI updates as needed
  } else {
  // Project sending failed
    AlertDialog(
      backgroundColor: Green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text('Sent Project',style: TextStyle(fontFamily: 'BigShotone',fontSize: 20,color: Colors.white,),),
      content: const Row(
        children: [
          Icon(Icons.check, color: Colors.black,size: 30,),
          SizedBox(width: 8),
          Text('SENT\nSUCCESSFULLY',style: TextStyle(fontFamily: 'BigShotone',fontSize: 20,color: Colors.white,),),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            setState(() {
              Navigator.of(context).pop();
            });
          },
          child: const Text('OK',style: TextStyle(fontFamily: 'BigShotone',fontSize: 20,color: Colors.white,),),
        ),
      ],
    );
  // Handle error or display message to user
  }
  } catch (error) {
  // Error occurred during the API call
  print('Error sending project: $error');
  // Handle error or display message to user
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ADD ADVERTISMENT',
          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'BigshotOne'),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body:
      Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Images/SplashScreen45.png'), // Your background image
              fit: BoxFit.cover,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 30),
              child: Container(
                width: 300,
                height: 490,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black,
                    width: 6,
                  ),
                ),
                child: Column(children: [
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
                    child:
                    TextFormField(
                      controller: AddCon,style: const TextStyle(fontFamily: 'BigshotOne',fontSize: 20),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                        hintText: 'Add Video URl',
                        hintStyle: const TextStyle(fontFamily: 'BigshotOne',fontSize: 20),
                        labelText: 'Add Video Url',
                        labelStyle: const TextStyle(fontFamily: 'BigshotOne',fontSize: 20),
                        prefixIcon: const Icon(Icons.video_call),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Background color
                    ),
                    onPressed: () {
                      setState(() {
                        Adverlis.add(Adver(url: AddCon.text));
                        setState(() {
                          if(Adverlis.isNotEmpty)
                          {
                            for(var w in Adverlis){
                              print('Data of List: ${w.url}');

                            }

                          }
                        });
                      });
                    },
                    child: Text(
                      'ADD',
                      style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'BigshotOne'), // Text color
                    ),
                  ),
                  SizedBox(height: 10,),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                        height: 200,
                        width: 320,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                              itemCount: Adverlis.length,
                              itemBuilder: (
                                  BuildContext context,int index)
                              {
                                return ListTile(
                                  title: Text(Adverlis[index].url.toString()),

                                );

                              }
                          )
                        )
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Background color
                    ),
                    onPressed: () {
                      var adddata=Adverlis.map((e) => {
                        'Url':e.url
                      }).toList();

                      print('ADDData: $adddata');
                    setState(() {
                      AddAdvertisementindb('32', adddata.toString());
                    });
                    },
                    child: Text(
                      'SENT',
                      style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'BigshotOne'), // Text color
                    ),
                  ),
                  SizedBox(height: 10,),
                ],),
              ),
            ),
          ),
        ),
      ],


      ),
    );
  }
}
