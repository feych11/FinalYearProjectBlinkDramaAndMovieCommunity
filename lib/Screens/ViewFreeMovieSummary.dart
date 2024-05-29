import 'package:flutter/material.dart';
import 'package:finalsemproject/API.dart';
import 'package:finalsemproject/Screens/EditorAddCommentsFroWriterScreen.dart';
import 'package:finalsemproject/Screens/WatchingScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ViewFreeMovieSummaryScreen extends StatefulWidget {
  final int? MovieID;
  final String? moviename;
  final int? FreeWriter_ID;
  final String? FreeWriterName;

  const ViewFreeMovieSummaryScreen(
      {Key? key, this.MovieID, this.moviename, this.FreeWriter_ID, this.FreeWriterName})
      : super(key: key);

  @override
  State<ViewFreeMovieSummaryScreen> createState() =>
      _ViewFreeMovieSummaryScreenState();
}

class _ViewFreeMovieSummaryScreenState
    extends State<ViewFreeMovieSummaryScreen> {
  String? summaryText;
  String? writerName = '';
  Duration? endtime;
  Duration? startTime;
  final Color Green = Color(0xFF4FAA6D);
  late final Map<String, dynamic> data;
  List<Map<String, dynamic>> clipsData = [];
  List<Map<String, String>> clipsInfoList = [];
  List<Map<String, dynamic>> summariesData = [];
  late YoutubePlayerController controller;
  bool isPlayerReady = false;
  int currentClipIndex = 0;
  bool init = false;

  bool hasRatedWriter = false;
  bool hasRatedMovie = false;

  Future<void> viewSentProject(int movieId) async {
    const String baseUrl = APIHandler.baseUrl1; // Update with your API base URL
    final String apiUrl = '$baseUrl/Editor/ViewSentProject?Movie_ID=$movieId';

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

  Future<void> UpdateWriterRating(int WriterID, int Rating) async {
    final String BaseUrl = APIHandler.baseUrl1;
    final Responce = await http.post(Uri.parse('$BaseUrl/Writer/UpdateWriterRating?writerId=$WriterID&rating=$Rating'));
    final Map<String, dynamic> Data = {
      'writerId': WriterID,
      'rating': Rating,
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

  Future<void> UpdateMovieRating(int Movieid, int Rating) async {
    final String BaseUrl = APIHandler.baseUrl1;
    final Responce = await http.post(Uri.parse('$BaseUrl/Writer/UpdateMovieRating?movieId=$Movieid&rating=$Rating'));
    final Map<String, dynamic> Data = {
      'movieId': Movieid,
      'rating': Rating,
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
    viewSentProject(widget.MovieID!);
    print('Movie ID: ${widget.MovieID}');
    print('Title::${widget.moviename}');
    print('Free Writer_ID::::: ${widget.FreeWriter_ID}');
    print('Free Writer_Name::::: ${widget.FreeWriterName}');
  }

  int _rating = 0;
  int _rating1 = 0;

  void _setRating(int rating) {
    setState(() {
      _rating = rating;
      print('RATING:: $_rating');
    });
  }

  void _setRating1(int rating) {
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

  void _handleRating(int rating, bool isWriterRating) {
    if (isWriterRating && hasRatedWriter || !isWriterRating && hasRatedMovie) {
      _showAlertDialog();
      return;
    }

    if (isWriterRating) {
      _setRating1(rating);
      UpdateWriterRating(widget.FreeWriter_ID!, _rating1);
      hasRatedWriter = true;
    } else {
      _setRating(rating);
      UpdateMovieRating(widget.MovieID!, _rating);
      hasRatedMovie = true;
    }
  }

  void _showAlertDialog() {
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

          child:

          AlertDialog(
          title: Text("Rating Submitted"),
          content: Text("Your response will be stored."),
          actions: [
            TextButton(
              child: Text("OK"),
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
    Widget loadingTextWidget = Padding(
      padding: const EdgeInsets.all(8.0),
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
              ),
            ),
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
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Reading',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.white,
              fontFamily: 'BigShotone'),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
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
                SizedBox(
                  height: 30,
                ),
                SizedBox(
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
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Colors.black,
                        Colors.black,
                        Colors.yellow,
                        Colors.yellow
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
                          child: Text(
                            'Read',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: 'BigshotOne'),
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
                            child: Text(
                              'Watch',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'BigshotOne'),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
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
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: 'BigshotOne',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Writer Rate:',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontFamily: 'BigshotOne',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(5, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    _handleRating(index + 1, true);
                                  },
                                  child: Icon(
                                    Icons.star,
                                    color: index < _rating1
                                        ? Colors.yellow
                                        : Colors.grey,
                                    size: 30.0, // Adjust the size of the stars if needed
                                  ),
                                );
                              }),
                            ) // Add the star rating widget here
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Summary Rate:',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontFamily: 'BigshotOne',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(5, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    _handleRating(index + 1, false);
                                  },
                                  child: Icon(
                                    Icons.star,
                                    color: index < _rating
                                        ? Colors.yellow
                                        : Colors.grey,
                                    size: 30.0, // Adjust the size of the stars if needed
                                  ),
                                );
                              }),
                            ) // Add the star rating widget here
                          ],
                        ),
                        SizedBox(height: 100,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 35,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 4,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(child: Text('READ',style: TextStyle(fontFamily: 'Jaro',fontSize: 15,color: Colors.black),)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 35,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 4,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(child: Text('BOOKMARK',style: TextStyle(fontFamily: 'Jaro',fontSize: 15,color: Colors.black),)),
                              ),
                            ),

                          ],)


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

class StarRatingWidget extends StatefulWidget {
  @override
  _StarRatingWidgetState createState() => _StarRatingWidgetState();
}

class _StarRatingWidgetState extends State<StarRatingWidget> {
  int _rating = 0;

  void _setRating(int rating) {
    setState(() {
      _rating = rating;
      print('RATING:: $_rating');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () => _setRating(index + 1),
          child: Icon(
            Icons.star,
            color: index < _rating ? Colors.yellow : Colors.grey,
            size: 30.0, // Adjust the size of the stars if needed
          ),
        );
      }),
    );
  }
}
