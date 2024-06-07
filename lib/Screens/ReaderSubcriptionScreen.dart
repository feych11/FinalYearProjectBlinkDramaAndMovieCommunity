import 'package:finalsemproject/Screens/ReaderSelectInterestsScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReaderSubcriptionScreen extends StatefulWidget {
  const ReaderSubcriptionScreen({super.key});

  @override
  State<ReaderSubcriptionScreen> createState() =>
      _ReaderSubcriptionScreenState();
}

class _ReaderSubcriptionScreenState extends State<ReaderSubcriptionScreen> {

  Future<void> updateSubscription(int RID, String newSubscription) async {
    try {
      String baseUrl='http://192.168.18.13/BlinkBackend/api/';
      // Replace 'YOUR_API_URL' with the actual API endpoint
      String url="${baseUrl}Reader/UpdateSubscription";

      // Create a map with the updated subscription data
      var requestData = {'Subscription': newSubscription};

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
        print("Subscription updated successfully");
      } else {
        print("Failed to update subscription. Error: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text(
          'SUBSCRIPTION',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Column(

        children: [
          const Center(child: Text('Choose Your Plan',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)),
          const SizedBox(height: 10,),
          Container(
            height: 150,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Row(
                children: [
                  const Text('Free',style: TextStyle(fontWeight: FontWeight.bold,fontSize:
                  20,color: Colors.white),),
                  const SizedBox(
                    width: 60,
                  ),
                  ElevatedButton(
                      onPressed: () async{
                        int RID=0;
                        String newSubscription='free';
                        updateSubscription(RID, newSubscription);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const ReaderSubcriptionScreen()));
                      },
                      child: const Text(
                        'SUBSCRIBE',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                      ))
                ],
              ),
              const SizedBox(height: 10,),
              const Text('1 Free Movie/Darama Daily',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)
            ],)

          ),
          const SizedBox(height: 10,),
          Container(
              height: 150,
              width: 300,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Text('Paid',style: TextStyle(fontWeight: FontWeight.bold,fontSize:
                      20,color: Colors.white),),
                      const SizedBox(
                        width: 60,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            int RID=1;
                            String newSubscription='Paid';
                            updateSubscription(RID, newSubscription);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const ReaderSelectInterestsScreen()));
                          },
                          child: const Text(
                            'SUBSCRIBE',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black),
                          ))
                    ],
                  ),
                  const SizedBox(height: 10,),
                  const Text('\$30',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                  const SizedBox(height: 10,),
                  const Text('Access To All Movies/Daramas',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                ],)

          ),
        ],
      ),
    );
  }
}
