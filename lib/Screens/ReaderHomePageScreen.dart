import 'dart:convert';

import 'package:finalsemproject/API.dart';
import 'package:finalsemproject/Screens/EditorViewAcceptedSummary.dart';
import 'package:finalsemproject/Screens/ReaderBottomNavScreen.dart';
import 'package:finalsemproject/Screens/ReaderLoginScreen.dart';
import 'package:finalsemproject/Screens/ReaderSelectInterestsScreen.dart';
import 'package:finalsemproject/Screens/ReaderSubcriptionScreen.dart';
import 'package:finalsemproject/Screens/ViewFreeMovieSummary.dart';
import 'package:finalsemproject/Screens/ViewPaidMovieSummary.dart';
import 'package:finalsemproject/Screens/WriterAccountSettingScreen1.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReaderHomePageScreen extends StatefulWidget {
  const ReaderHomePageScreen({super.key});

  @override
  State<ReaderHomePageScreen> createState() => _ReaderHomePageScreenState();
}

class _ReaderHomePageScreenState extends State<ReaderHomePageScreen> {
  final TextEditingController _balanceController = TextEditingController();
  String ?userId;
  int? Writer_ID;
  String? ReaderName;
  String ?Subscription;
  String? ReaderBalance;
  String? ReaderImage;
  int? movieID;
  int?FreeWriter_ID;
  String?FreeWriterName;
  String?movieName;
  String ?movieImage;
  String?movieType;
  final Color mateBlack = Color(0xFF242424);
  bool _isSearching = false;
  String _searchQuery = "";
  List<Map<String,dynamic>>notifications2=[];
  List<dynamic> movieDetails = [];


  Future<void> addReaderFavorites(int readerId, int writerId, int movieId) async {



    final String url = '${APIHandler.baseUrl1}/Reader/AddReaderFavorites?readerId=$readerId&writerId=$writerId&movieId=$movieId';

    final response = await http.post(
      Uri.parse(url),
);

    if (response.statusCode == 200) {
      print('Added to favorites');
    } else {
      print('Failed to add to favorites: ${response.reasonPhrase}');
    }
  }
  Future<void>SendBalanceRequest(String newbalance)async
  {
    final String baseurl=APIHandler.baseUrl1;
    final Responce=await http.put(Uri.parse('$baseurl/Reader/SendBalanceRequest?Reader_ID=$userId&Amount=$newbalance'),

      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'Reader_ID': userId,
        'newBalance': newbalance,
      }),
    );

    try{
      if(Responce.statusCode==200){
        print('Balance Recharge Successfully');
      }
      else
      {
        print('Unable To  Recharge Balance ');
      }
    }
    catch(error)
    {
      print('Unable To Recharge Your Balance ${error}');
    }
  }

  
  Future<void> issueFreeMovie() async {
    final String baseUrl = APIHandler.baseUrl1;

    const String baseurl3=APIHandler.baseUrl2;// Replace with your API base URL
    final response = await http.get(Uri.parse('$baseUrl/Reader/IssueFreeMovie?readerId=${userId.toString()}'));
    try {


      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final moviedata = jsonData['Movie'];
        final writerData=jsonData['Writer'];
        setState(() {
          // Assign data to class-level variables
          movieID=jsonData['Movie']['Movie_ID'];
          movieName = jsonData['Movie']['Name'];
          movieImage = '$baseurl3/Images/${jsonData['Movie']['Image']}';
          movieType = jsonData['Movie']['Type'];
          FreeWriter_ID=jsonData['Writer']['Writer_ID'];
          FreeWriterName=jsonData['Writer']['UserName'];

        });
        // Print or use the movie details here
        print('Movie _ID: $movieID');
        print('Movie Name: $movieName');
        print('Movie Image: $movieImage');
        print('Movie Type: $movieType');
        print('Writer_ID::: $Writer_ID');


        final issueDate = jsonData['issueDate'];
        final issuedMovie=jsonData['IssuedMovie'];

        // Now you can use the movie, writer, and issuedMovie data as needed
        // For example, you can display the information in your UI
        print('Movie Data: $moviedata');
        print('Movie _ID: $movieID');
        print('Movie Name: $movieName');
        print('Movie Image: $movieImage');
        print('Movie Type: $movieType');
        print('Writer: $Writer_ID');
        print('issueDate:${issueDate}');
        print('Issued Movie: $issuedMovie');
        print('Free Writer ID:${FreeWriter_ID}');
      } else {
        // Handle other status codes here
        print('Failed to issue free movie: ${response.reasonPhrase}');

      }
    } catch (e) {
      print('Error issuing free movie: $e');

    }
  }

  void _showRechargeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
            data: ThemeData( // Define custom theme data
            dialogBackgroundColor: Colors.grey, // Background color
            dialogTheme: DialogTheme( // Define dialog theme
            shape: RoundedRectangleBorder( // Define border shape
            side: BorderSide(color: Colors.black,width: 4), // Border color
        borderRadius: BorderRadius.circular(20.0), // Border radius
        ),
        ),
        ),
        child: AlertDialog(
          title: Text('Recharge Balance',style: TextStyle(fontSize: 25,fontFamily: 'BigshotOne'),),
          content: TextField(
            controller: _balanceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "Enter new balance"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel',style: TextStyle(fontSize: 20,fontFamily: 'BigshotOne',color: Colors.black),),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Recharge',style: TextStyle(fontSize: 20,fontFamily: 'BigshotOne',color: Colors.black),),
              onPressed: (){
                SendBalanceRequest(_balanceController.text);
              }
            ),
          ],
        )
        );
      },
    );
  }


  Future<void> issuePaidMovies() async {
    final String baseUrl2 = APIHandler.baseUrl1;
    final String baseUrl3 = APIHandler.baseUrl2;
    try {
      final response = await http.get(Uri.parse('$baseUrl2/Reader/IssuePaidMovie'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        // Assuming 'Project' contains the list of accepted projects
        final List<dynamic> projects = data['Project'];
        setState(() {
          notifications2 = projects.map((project) {
            return {
              'Movieid':project['Movie_ID'],
              'id': project['SentProject_ID'],
              'title': project['ProposalData']['Movie_Name'],
              'WriterId': project['Writer_ID'],
              'director': project['ProposalData']['Director'],
              'type': project['ProposalData']['Type'],
              'rating': 4,
              'UserName':project['WriterData']['UserName'],
              'imagePath': '$baseUrl3/Images/${project['ProposalData']['Image']}',
              'status': project['Status'],
            };
          }).toList();
        });
      } else {
        throw Exception('Failed to load accepted projects');
      }
    } catch (error) {
      print('Failed to load accepted projects: $error');
    }
  }
  Future<void> getUserIdFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('Reader_ID');
    final username=prefs.getString('Username1');
    final Subscription1=prefs.getString('Subscription');
    final userbalance=prefs.getString('Balance');
    final userImage=prefs.getString('UserImage1');
    setState(() {
      userId = user;
      ReaderName=username;
      Subscription=Subscription1;
      ReaderBalance=userbalance;
      ReaderImage=userImage;
      print('jskksd: ${userId}');
      print('ReaderName: ${ReaderName}');
      print('Subscription::: $Subscription');
      print('Reader Balance: ${ReaderBalance}');
      print('ReaderImageL ${ReaderImage}');
    });
    if (userId != null) {
      if(Subscription=='Free'){
        issueFreeMovie();
      }
      else if(Subscription=='Paid')
        {
          issuePaidMovies();
        }

      print('Movie Image: $movieImage');
      // print('Getrewrtedata:${getRewriteData}');

      print('ghjk:${userId}');
      print('ReaderName: ${ReaderName}');
      print('Reader Balance: ${ReaderBalance}');
      print('ReaderImageL ${ReaderImage}');
    }
  }

  @override
  void initState(){
    super.initState();
    getUserIdFromSharedPreferences();

  }

  @override
  Widget build(BuildContext context) {
    final filteredNotifications = notifications2
        .where((notification) =>
        notification['title']!.toLowerCase().startsWith(_searchQuery.toLowerCase()))
        .toList();
    return Scaffold(
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
                      backgroundImage: NetworkImage(ReaderImage.toString()),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          ReaderName.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: 'Jura'),
                        ),
                        Text(
                          'Balance:$ReaderBalance',
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
              onTap: _showRechargeDialog, // Show the alert dialog on tap
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
        title: _isSearching
            ? TextField(
          onChanged: (query) {
            setState(() {
              _searchQuery = query;
            });
          },
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Jaro',color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white),
          ),
        )
            : Center(child: Text('Home Page',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Jaro',color: Colors.white),)),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchQuery = "";
                }
              });
            },
          ),
        ],
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey,
      body: Subscription == 'Free'
          ?Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Images/bgimg1.png'), // Your background image
              fit: BoxFit.cover,
            ),
          ),
        ),
            Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Card(
          //   elevation: 5,
          //   color: Colors.white,
          //   child: Text('Discover',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewFreeMovieSummaryScreen( )));
                },
                child: Container(

                  height: 270,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.white,
                      width: 4,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                             'Free Daily',
                              style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold,fontFamily: 'Rye'),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewFreeMovieSummaryScreen(   FreeWriter_ID: FreeWriter_ID,
                                    MovieID: movieID,
                                    moviename: movieName,
                                    FreeWriterName:FreeWriterName)));
                              },
                              child: Container(
                                height: 150,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.white),
                                child:movieImage != null
                                    ? Image.network(movieImage!,fit: BoxFit.cover)

                                    : Container(),


                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),border: Border.all(
                            color: Colors.black,
                            width: 4,
                          ),),
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(

                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                Text(
                                  movieName.toString(),
                                  style: TextStyle(color: Colors.black,fontSize:15,fontWeight: FontWeight.bold,fontFamily:'BigshotOne'),
                                ),
                                InkWell
                                  (
                                    onTap: (){
                                      // Assuming userId, FreeWriter_ID, and movieID are nullable types

// Check for nullability and convert to non-nullable types if possible
                                      int userId1 = userId != null ? int.parse(userId.toString()) : 0;
                                      int FreeWriter_ID1 = FreeWriter_ID != null ? int.parse(FreeWriter_ID.toString()) : 0;
                                      int movieID1 = movieID != null ? int.parse(movieID.toString()) : 0;

// Call the addReaderFavorites function with non-nullable integer arguments
                                      addReaderFavorites(userId1, FreeWriter_ID1, movieID1);
                                    },
                                    child: Icon(Icons.favorite,color: Colors.red,size: 30,))
                              ],),
                              Text(
                                '                 Type: ${movieType.toString()}',
                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15,fontFamily: 'BigshotOne'),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                elevation: 5,
                color: Colors.white,
                shape: RoundedRectangleBorder( // Define border shape
                  side: BorderSide(color: Colors.black,width: 4), // Border color
                  borderRadius: BorderRadius.circular(20.0), // Border radius
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'TOP PICK',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Jaro'),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  color: Colors.white,
                  shape: RoundedRectangleBorder( // Define border shape
                    side: BorderSide(color: Colors.black,width: 4), // Border color
                    borderRadius: BorderRadius.circular(20.0), // Border radius
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'SEE ALL',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Jaro'),
                    ),
                  ),
                ),

              ),
            ],),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      // Show alert dialog here
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Theme(
                              data: ThemeData( // Define custom theme data
                                dialogBackgroundColor: Colors.grey, // Background color
                                dialogTheme: DialogTheme( // Define dialog theme
                                  shape: RoundedRectangleBorder( // Define border shape
                                    side: BorderSide(color: Colors.black,width: 4), // Border color
                                    borderRadius: BorderRadius.circular(20.0), // Border radius
                                  ),
                                ),
                              ),
                              child: AlertDialog(
                                title: Text('Alert',style: TextStyle(fontSize: 25,fontFamily: 'BigshotOne'),),
                                content: Text('You are on free mode',style: TextStyle(fontFamily: 'BigshotOne',fontSize: 20),),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK',style: TextStyle(fontFamily: 'BigshotOne',fontSize: 20,color: Colors.black),),
                                  ),
                                ],
                              ));
                        },
                      );
                    },
                    child: Container(
                        height: 160,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                            color: Colors.black),
                        child: Column(children: [
                          Image.asset(

                            'Images/parwaz2.jpg',
                            height: 100,
                            width: 70,
                            fit: BoxFit.cover,),
                          Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),

                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Maula Jutt',
                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontFamily: 'Jaro'),
                                  ),
                                  Text(
                                    'Paid',
                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15,fontFamily: 'Jaro'),
                                  ),]),
                          )
                        ],)
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: () {
                      // Show alert dialog here
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Theme(
                              data: ThemeData( // Define custom theme data
                                dialogBackgroundColor: Colors.grey, // Background color
                                dialogTheme: DialogTheme( // Define dialog theme
                                  shape: RoundedRectangleBorder( // Define border shape
                                    side: BorderSide(color: Colors.black,width: 4), // Border color
                                    borderRadius: BorderRadius.circular(20.0), // Border radius
                                  ),
                                ),
                              ),
                              child: AlertDialog(
                                title: Text('Alert',style: TextStyle(fontSize: 25,fontFamily: 'BigshotOne'),),
                                content: Text('You are on free mode',style: TextStyle(fontFamily: 'BigshotOne',fontSize: 20),),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK',style: TextStyle(fontFamily: 'BigshotOne',fontSize: 20,color: Colors.black),),
                                  ),
                                ],
                              ));
                        },
                      );
                    },
                    child: Container(
                        height: 160,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.black,
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),),
                        child: Column(children: [
                          Image.asset(

                            'Images/manm2.jpg',
                            height: 100,
                            width: 70,
                            fit: BoxFit.cover,),
                          Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)

                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Man Mayal',
                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontFamily: 'Jaro'),
                                  ),
                                  Text(
                                    'Paid',
                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15,fontFamily: 'Jaro'),
                                  ),]),
                          )
                        ],)
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: () {
                      // Show alert dialog here
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Theme(
                              data: ThemeData( // Define custom theme data
                                dialogBackgroundColor: Colors.grey, // Background color
                                dialogTheme: DialogTheme( // Define dialog theme
                                  shape: RoundedRectangleBorder( // Define border shape
                                    side: BorderSide(color: Colors.black,width: 4), // Border color
                                    borderRadius: BorderRadius.circular(20.0), // Border radius
                                  ),
                                ),
                              ),
                              child: AlertDialog(
                                title: Text('Alert',style: TextStyle(fontSize: 25,fontFamily: 'BigshotOne'),),
                                content: Text('You are on free mode',style: TextStyle(fontFamily: 'BigshotOne',fontSize: 20),),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK',style: TextStyle(fontFamily: 'BigshotOne',fontSize: 20,color: Colors.black),),
                                  ),
                                ],
                              ));
                        },
                      );
                    },
                    child: Container(
                        height: 160,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.black,
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),),
                        child: Column(children: [
                          Image.asset(

                            'Images/waar1.jpg',
                            height: 100,
                            width: 70,
                            fit: BoxFit.cover,),
                          Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                              // border: Border.all(
                              //   color: Colors.black,
                              //   width: 2,
                              //
                              // ),

                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Waar',
                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontFamily: 'Jaro'),
                                  ),
                                  Text(
                                    'Paid',
                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15,fontFamily: 'Jaro'),
                                  ),]),
                          )
                        ],)
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: () {
                      // Show alert dialog here
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Theme(
                              data: ThemeData( // Define custom theme data
                                dialogBackgroundColor: Colors.grey, // Background color
                                dialogTheme: DialogTheme( // Define dialog theme
                                  shape: RoundedRectangleBorder( // Define border shape
                                    side: BorderSide(color: Colors.black,width: 4), // Border color
                                    borderRadius: BorderRadius.circular(20.0), // Border radius
                                  ),
                                ),
                              ),
                              child: AlertDialog(
                                title: Text('Alert',style: TextStyle(fontSize: 25,fontFamily: 'BigshotOne'),),
                                content: Text('You are on free mode',style: TextStyle(fontFamily: 'BigshotOne',fontSize: 20),),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK',style: TextStyle(fontFamily: 'BigshotOne',fontSize: 20,color: Colors.black),),
                                  ),
                                ],
                              ));
                        },
                      );
                    },
                    child: Container(
                        height: 160,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.black,
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),),
                        child: Column(children: [
                          Image.asset(

                            'Images/Dukhtar1.png',
                            height: 100,
                            width: 70,
                            fit: BoxFit.cover,),
                          Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)

                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Dukhtar',
                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontFamily: 'Jaro'),
                                  ),
                                  Text(
                                    'Paid',
                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15,fontFamily: 'Jaro'),
                                  ),]),
                          )
                        ],)
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: () {
                      // Show alert dialog here
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Theme(
                              data: ThemeData( // Define custom theme data
                                dialogBackgroundColor: Colors.grey, // Background color
                                dialogTheme: DialogTheme( // Define dialog theme
                                  shape: RoundedRectangleBorder( // Define border shape
                                    side: BorderSide(color: Colors.black,width: 4), // Border color
                                    borderRadius: BorderRadius.circular(20.0), // Border radius
                                  ),
                                ),
                              ),
                              child: AlertDialog(
                                title: Text('Alert',style: TextStyle(fontSize: 25,fontFamily: 'BigshotOne'),),
                                content: Text('You are on free mode',style: TextStyle(fontFamily: 'BigshotOne',fontSize: 20),),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK',style: TextStyle(fontFamily: 'BigshotOne',fontSize: 20,color: Colors.black),),
                                  ),
                                ],
                              ));
                        },
                      );
                    },
                    child: Container(
                        height: 160,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.black,
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),),
                        child: Column(children: [
                          Image.asset(

                            'Images/snge2.jpg',
                            height: 100,
                            width: 70,
                            fit: BoxFit.cover,),
                          Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)

                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Sangemarmar',
                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontFamily: 'Jaro'),
                                  ),
                                  Text(
                                    'Paid',
                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15,fontFamily: 'Jaro'),
                                  ),]),
                          )
                        ],)
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: () {
                      // Show alert dialog here
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Theme(
                              data: ThemeData( // Define custom theme data
                                dialogBackgroundColor: Colors.grey, // Background color
                                dialogTheme: DialogTheme( // Define dialog theme
                                  shape: RoundedRectangleBorder( // Define border shape
                                    side: BorderSide(color: Colors.black,width: 4), // Border color
                                    borderRadius: BorderRadius.circular(20.0), // Border radius
                                  ),
                                ),
                              ),
                              child: AlertDialog(
                                title: Text('Alert',style: TextStyle(fontSize: 25,fontFamily: 'BigshotOne'),),
                                content: Text('You are on free mode',style: TextStyle(fontFamily: 'BigshotOne',fontSize: 20),),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK',style: TextStyle(fontFamily: 'BigshotOne',fontSize: 20,color: Colors.black),),
                                  ),
                                ],
                              ));
                        },
                      );
                    },
                    child: Container(
                        height: 160,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.black,
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),),
                        child: Column(children: [
                          Image.asset(

                            'Images/actorinlaw1.jpg',
                            height: 100,
                            width: 70,
                            fit: BoxFit.cover,),
                          Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)

                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Actor in Law',
                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontFamily: 'Jaro'),
                                  ),
                                  Text(
                                    'Paid',
                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15,fontFamily: 'Jaro'),
                                  ),]),
                          )
                        ],)
                    ),
                  ),
                ],),
            ),
          )

        ],
      )],)
          :
      Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Images/SplashScreen45.png'), // Your background image
              fit: BoxFit.cover,
            ),
          ),
        ),


        SingleChildScrollView(child:

        SafeArea(child: Column(
          children: [
            Column(
              children: filteredNotifications.map((notification) {
                return buildNotificationCard2(notification);
              }).toList(),
            ),
          ],
        ))),
      ],)
    );
  }
  Widget buildNotificationCard2(Map<String, dynamic> notification2) {
    final int id = notification2['id'] ?? '';
    final int WriterId=notification2['WriterId']??'';
    final int Movieid = notification2['Movieid'] ?? '';
    final String title = notification2['title'] ?? '';
    final String UserName=notification2['UserName']?? '';
    final String director = notification2['director'] ?? '';
    final String status = notification2['status'] ?? '';
    final String type = notification2['type'] ?? '';


    final String imagePath = notification2['imagePath'] ?? '';

    return Padding(
      padding: const EdgeInsets.all(8.0),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(imagePath), // Use Image.network for remote images
            ),
            SizedBox(width: 10),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(color: mateBlack),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'BigshotOne'
                        ),
                      ),
                      InkWell
                        (
                          onTap: (){
                            // Assuming userId, FreeWriter_ID, and movieID are nullable types

// Check for nullability and convert to non-nullable types if possible
                            int userId1 = userId != null ? int.parse(userId.toString()) : 0;
                            int Writer_ID1 = WriterId != null ? int.parse(WriterId.toString()) : 0;
                            int movieID1 = Movieid != null ? int.parse(Movieid.toString()) : 0;

// Call the addReaderFavorites function with non-nullable integer arguments
                            addReaderFavorites(userId1, Writer_ID1, movieID1);
                          },
                          child: Icon(Icons.favorite,color: Colors.red,size: 30,)),
                    ],),
                    SizedBox(height: 10),


                    Row(
                      children: [
                        Text(
                          'Director:',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          director,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          'Type:',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                        SizedBox(width: 6),
                        Text(
                          type,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    //SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          'Writer:',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                        SizedBox(width: 6),
                        Text(
                          UserName,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Rye'
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Center(
                      child: GestureDetector(
                        onTap: (){

                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPaidMovieSummaryScreen(FreeWriter_ID: WriterId,MovieID: Movieid,)));

                        },
                        child: Container(
                          height: 30,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(child: Text('View',style: TextStyle(fontSize: 20,fontFamily: 'Rye',fontWeight: FontWeight.bold),)),
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
