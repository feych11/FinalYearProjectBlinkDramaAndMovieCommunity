import 'package:flutter/material.dart';
import 'package:finalsemproject/API.dart';
import 'package:finalsemproject/Screens/WatchingScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewPaidMovieSummaryScreen extends StatefulWidget {
  final int? MovieID;
  final String? moviename;
  final int? FreeWriter_ID;
  final String? FreeWriterName;

  const ViewPaidMovieSummaryScreen({
    super.key,
    this.MovieID,
    this.moviename,
    this.FreeWriter_ID,
    this.FreeWriterName,
  });

  @override
  State<ViewPaidMovieSummaryScreen> createState() => _ViewPaidMovieSummaryScreenState();
}

class _ViewPaidMovieSummaryScreenState extends State<ViewPaidMovieSummaryScreen> {
  String? summaryText;
  String? writerName = '';
  Duration? endtime;
  Duration? startTime;
  String ?userId;
  String? ReaderName;
  String ?Subscription;
  String? ReaderBalance;
  String? ReaderImage;
  final Color Green = const Color(0xFF4FAA6D);
  late final Map<String, dynamic> data;
  List<Map<String, dynamic>> clipsData = [];
  List<Map<String, String>> clipsInfoList = [];
  List<Map<String, dynamic>> summariesData = [];
  late YoutubePlayerController controller;
  bool isPlayerReady = false;
  int currentClipIndex = 0;
  bool init = false;

  Future<void> viewSentProject(int movieId,int WriterID) async {
    const String baseUrl = APIHandler.baseUrl1; // Update with your API base URL
    final String apiUrl = '$baseUrl/Editor/ViewSentProject?Movie_ID=$movieId&WriterID=$WriterID';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        // Extract summary data
        List<dynamic> summaryList = data['Summary'];
        summariesData = List<Map<String, dynamic>>.from(summaryList);

        // Extract clips data
        List<dynamic> clipsListt = data['Clips'];
        clipsData = List<Map<String, dynamic>>.from(clipsListt);

        for (var clip in clipsData) {
          if (clip['isCompoundClip']) {
            clipsInfoList.add({
              'Start_time': clip['Start_time'],
              'End_time': clip['End_time'],
              'Url': clip['Url'],
            });
          }
        }

        // Process the data as needed
        print('Summaries Data: $summariesData');
        print('Clips Data: $clipsData');
        print('ClipsInfo: $clipsInfoList');
        refreshPage();
      } else {
        print('Failed to view sent project: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error viewing sent project: $e');
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
      print('jskksd: $userId');
      print('ReaderName: $ReaderName');
      print('Subscription::: $Subscription');
      print('Reader Balance: $ReaderBalance');
      print('ReaderImageL $ReaderImage');
    });

  }

  Future<void> UpdateWriterRating(int WriterID, double Rating,String ReaderID) async {
    const String BaseUrl = APIHandler.baseUrl1;
    final Responce = await http.post(Uri.parse('$BaseUrl/Writer/UpdateWriterRating?Reader_ID=$ReaderID&writerId=$WriterID&rating=$Rating'));
    final Map<String, dynamic> Data = {
      'writerId': WriterID,
      'rating': Rating,
      'Reader_ID':ReaderID
    };
    body: jsonEncode(Data);
    try {
      if (Responce.statusCode == 200) {
        print('Update Writer Rating');
      } else {
        final Map<String, dynamic> responseBody = jsonDecode(Responce.body);
        print('Unable To Update Writer Rating: ${responseBody['Message']}');
      }
    } catch (ex) {
      print('Unable To Update Writer Rating $ex');
    }
  }

  Future<void> UpdateMovieRating(int Movieid, double Rating,String ReaderID) async {
    const String BaseUrl = APIHandler.baseUrl1;
    final Responce = await http.post(Uri.parse('$BaseUrl/Writer/UpdateMovieRating?Reader_ID=$ReaderID&movieId=$Movieid&rating=$Rating'));
    final Map<String, dynamic> Data = {
      'movieId': Movieid,
      'rating': Rating,
      'Reader_ID':ReaderID,
    };
    body: jsonEncode(Data);
    try {
      if (Responce.statusCode == 200) {
        print('Update Movie Rating');
      } else {
        final Map<String, dynamic> responseBody = jsonDecode(Responce.body);
        print('Unable To Update Movie Rating: ${responseBody['Message']}');
      }
    } catch (ex) {
      print('Unable To Update Movie Rating $ex');
    }
  }

  @override
  void initState() {
    super.initState();
    getUserIdFromSharedPreferences();
    viewSentProject(widget.MovieID!,widget.FreeWriter_ID!);
    print('Movie ID: ${widget.MovieID}');
    print('Title::${widget.moviename}');
    print('Free Writer_ID::::: ${widget.FreeWriter_ID}');
    print('Free Writer_Name::::: ${widget.FreeWriterName}');
  }

  double _rating = 0;
  double _rating1 = 0;

  void _setRating(double rating) {
    setState(() {
      _rating = rating;
      print('RATING:: $_rating');
    });
  }

  void _setRating1(double rating) {
    setState(() {
      _rating1 = rating;
      print('RATING:: $_rating1');
    });
  }

  void refreshPage() {
    setState(() {
      summaryText = summariesData.isNotEmpty ? summariesData.last['Summary1'].toString() : '';
    });
  }

  void _handleRating(double rating, bool isWriterRating) {
    if (isWriterRating ) {
      _setRating1(rating);
      UpdateWriterRating(widget.FreeWriter_ID!, _rating1,userId.toString());
    }
    else {
      _setRating(rating);
      UpdateMovieRating(widget.MovieID!, _rating,userId.toString());

    }
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return
          Theme(
            data: ThemeData( // Define custom theme data
            dialogBackgroundColor: Colors.grey, // Background color
            dialogTheme: DialogTheme( // Define dialog theme
            shape: RoundedRectangleBorder( // Define border shape
            side: const BorderSide(color: Colors.black,width: 4), // Border color
        borderRadius: BorderRadius.circular(20.0), // Border radius
        ),
        ),
        ),

        child:
          AlertDialog(
          title: const Text('Rating Submitted'),
          content: const Text('Your response will be stored.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingTextWidget = const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Loading Video...',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );

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
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Balance:2000',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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
              ),
            ),
            ListTile(
              title: const Text(
                'Home',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              onTap: () {
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text(
                'Subscription:Free',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text(
                'Update Interest',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              onTap: () {
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text(
                'Recharge Balance',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              onTap: () {
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text(
                'Account Setting',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
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
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Reading',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white,
            fontFamily: 'BigShotone',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('Images/SplashScreen45.png'), // Your background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 4,
                    ),
                    gradient: const LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Colors.black,
                        Colors.black,
                        Colors.yellow,
                        Colors.yellow,
                      ],
                      stops: [0.0, 0.5, 0.5, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => EditorReadingScreen()));
                          },
                          child: const Text(
                            'Read',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                              fontFamily: 'BigshotOne',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {},
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WatchingScreen(
                                      moviename: widget.moviename,
                                      clipsData: clipsData,
                                      ClipsInfoList: clipsInfoList,
                                    ),
                                  ),
                                );
                              });
                            },
                            child: const Text(
                              'Watch',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'BigshotOne',
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    height: 400,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: Colors.white,
                        width: 4,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            summaryText ?? 'Loading summary...',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: 'BigshotOne',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Writer Rate:',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontFamily: 'BigshotOne',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(5, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    _handleRating(index + 1, true);
                                  },
                                  child: Icon(
                                    Icons.star,
                                    color: index < _rating1 ? Colors.yellow : Colors.grey,
                                    size: 30.0, // Adjust the size of the stars if needed
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Summary Rate:',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontFamily: 'BigshotOne',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(5, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    _handleRating(index + 1, false);
                                  },
                                  child: Icon(
                                    Icons.star,
                                    color: index < _rating ? Colors.yellow : Colors.grey,
                                    size: 30.0, // Adjust the size of the stars if needed
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                        const SizedBox(height: 100,),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //   Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Container(
                        //       height: 35,
                        //       width: 80,
                        //       decoration: BoxDecoration(
                        //         color: Colors.yellow,
                        //         border: Border.all(
                        //           color: Colors.white,
                        //           width: 4,
                        //         ),
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //       child: const Center(child: Text('READ',style: TextStyle(fontFamily: 'Jaro',fontSize: 15,color: Colors.black),)),
                        //     ),
                        //   ),
                        //   Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Container(
                        //       height: 35,
                        //       width: 100,
                        //       decoration: BoxDecoration(
                        //         color: Colors.yellow,
                        //         border: Border.all(
                        //           color: Colors.white,
                        //           width: 4,
                        //         ),
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //       child: const Center(child: Text('BOOKMARK',style: TextStyle(fontFamily: 'Jaro',fontSize: 15,color: Colors.black),)),
                        //     ),
                        //   ),
                        //
                        // ],)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
