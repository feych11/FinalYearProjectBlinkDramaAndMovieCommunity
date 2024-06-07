import 'package:finalsemproject/Screens/ReaderHomePageScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
class ReaderSelectInterestsScreen extends StatefulWidget {
  const ReaderSelectInterestsScreen({super.key});

  @override
  State<ReaderSelectInterestsScreen> createState() => _ReaderSelectInterestsScreenState();
}

class _ReaderSelectInterestsScreenState extends State<ReaderSelectInterestsScreen> {
  String base_url='http://192.168.18.13/BlinkBackend/api/';
  Future<void> updateInterest(int RID, List<String> newInterest) async {
    try {
      // Replace 'YOUR_API_URL' with the actual API endpoint
      String url="${base_url}Reader/UpdateInterests";

      // Create a map with the updated subscription data
      var requestData = {'Interests': newInterest};

      // Convert the map to JSON
      var requestBody = jsonEncode(requestData);

      Uri uri=Uri.parse(url);
      // Make the PUT request
      var response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: requestBody,
      );

      // Handle the response
      if (response.statusCode == 200) {
        print("Interest updated successfully");
      } else {
        print("Failed to update Interest. Error: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
 List<String> newInterest=[];
  bool checked=false;
  bool checked1=false;
  bool checked2=false;
  bool checked3=false;
  bool checked4=false;
  bool checked5=false;
  bool checked6=false;
  bool checked7=false;
  bool checked8=false;
  bool checked9=false;
  bool checked10=false;
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

            Row(

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Column(
                children: [
                  CheckboxListTile(title: Text('$checked'),
                  value: newInterest.contains(checked), onChanged: ( value)
                  {
                    setState(() {
                      if(value!){
                        newInterest.add(checked.toString());
                      }else{
                        newInterest.remove(checked.toString());
                      }
                    });
                  }),
                  const Text('Horror',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  CheckboxListTile(title: Text('$checked1'),
                      value: newInterest.contains(checked1), onChanged: ( value)
                      {
                        setState(() {
                          if(value!){
                            newInterest.add(checked1.toString());
                          }else{
                            newInterest.remove(checked1.toString());
                          }
                        });
                      }),
                  const Text('Action',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  CheckboxListTile(title: Text('$checked2'),
                      value: newInterest.contains(checked2), onChanged: ( value)
                      {
                        setState(() {
                          if(value!){
                            newInterest.add(checked2.toString());
                          }else{
                            newInterest.remove(checked2.toString());
                          }
                        });
                      }),
                  const Text('Comedy',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  CheckboxListTile(title: Text('$checked3'),
                      value: newInterest.contains(checked3), onChanged: ( value)
                      {
                        setState(() {
                          if(value!){
                            newInterest.add(checked3.toString());
                          }else{
                            newInterest.remove(checked3.toString());
                          }
                        });
                      }),
                  const Text('Sci-Fi',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                ],
              ),
              // SizedBox(height: 10,),
              Column(
                children: [
                  CheckboxListTile(title: Text('$checked4'),
                      value: newInterest.contains(checked4), onChanged: ( value)
                      {
                        setState(() {
                          if(value!){
                            newInterest.add(checked4.toString());
                          }else{
                            newInterest.remove(checked4.toString());
                          }
                        });
                      }),
                  const Text('Fantasy',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  const SizedBox(height: 10,),
                  CheckboxListTile(title: Text('$checked5'),
                      value: newInterest.contains(checked5), onChanged: ( value)
                      {
                        setState(() {
                          if(value!){
                            newInterest.add(checked5.toString());
                          }else{
                            newInterest.remove(checked5.toString());
                          }
                        });
                      }),
                  const Text('Darama',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  const SizedBox(height: 10,),
                  CheckboxListTile(title: Text('$checked6'),
                      value: newInterest.contains(checked6), onChanged: ( value)
                      {
                        setState(() {
                          if(value!){
                            newInterest.add(checked6.toString());
                          }else{
                            newInterest.remove(checked6.toString());
                          }
                        });
                      }),
                  const Text('Thriller',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  const SizedBox(height: 10,),
                  CheckboxListTile(title: Text('$checked7'),
                      value: newInterest.contains(checked7), onChanged: ( value)
                      {
                        setState(() {
                          if(value!){
                            newInterest.add(checked7.toString());
                          }else{
                            newInterest.remove(checked7.toString());
                          }
                        });
                      }),
                  const Text('Crime',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  const SizedBox(height: 10,),
                  CheckboxListTile(title: Text('$checked8'),
                      value: newInterest.contains(checked8), onChanged: ( value)
                      {
                        setState(() {
                          if(value!){
                            newInterest.add(checked8.toString());
                          }else{
                            newInterest.remove(checked8.toString());
                          }
                        });
                      }),
                  const Text('Animation',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  const SizedBox(height: 10,),

                ],
              ),
            ],),
            const SizedBox(height: 30,),
              Center(
                  child: InkWell(
                    onTap: (){
                      int RID=1;
                      updateInterest(RID, newInterest);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const ReaderHomePageScreen()));
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
