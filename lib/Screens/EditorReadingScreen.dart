import 'package:finalsemproject/API.dart';
import 'package:finalsemproject/Screens/EditorAddCommentsFroWriterScreen.dart';
import 'package:finalsemproject/Screens/WatchingScreen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class EditorReadingScreen extends StatefulWidget {
  final String ?MovieID;
  final String ?sentProjectID;
  final String?moviename;


  const EditorReadingScreen({Key? key ,
    this.MovieID,
    this.sentProjectID,
    this.moviename
  }) : super(key: key);

  @override
  State<EditorReadingScreen> createState() => _EditorReadingScreenState();
}

class _EditorReadingScreenState extends State<EditorReadingScreen> {
  String? summaryText;
  String? writerName = '';
  Duration? endtime;
  Duration? startTime;
  final Color Green  = Color(0xFF4FAA6D);
  late final Map<String, dynamic> data;
  //late List<dynamic> clipsData;
  List<Map<String, dynamic>> clipsData = [];
  List<Map<String, String>> clipsInfoList = [];
  List<Map<String, dynamic>> summariesData = [];
  late YoutubePlayerController controller;
   bool isPlayerReady = false;
  // int index=0;
  //bool assigned=false;
  int currentClipIndex = 0;
  bool init=false;
  Future<void> fetchSummary(String sentProjectID) async {
    const String baseUrl =  APIHandler.baseUrl1;
    final String apiUrl =
        '$baseUrl/Editor/FetchSummary?sentProjectId=$sentProjectID';
    print('dataaa');
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        data = json.decode(response.body);
        // Extract summary data from the response
        // final List<dynamic>? summaryList = data['SummaryData']['Summary1'];
        // final String? summaryText = summaryList != null && summaryList.isNotEmpty
        //     ? summaryList[0]['Summary1'] // Assuming the summary is in the first item of the list
        //     : null;
        //print('Summary Data: '+data['SummaryData']['Summary1'].toString());
       // summaryText = data['SummaryData']['Summary1'].toString();

        //clipsData = data['ClipsData'];
       // print('clipDataList = '+ clipsData.toString());


        //print('Writer Name: $writerName');
        // Process the data as needed
        //print('data: $data');
      } else {
        print('Failed to fetch summary: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching summary: $e');
    }
  }

  Future<void>AcceptSentProject(String SentprojectID)async
  {
    try
    {
      const String baseurl2=APIHandler.baseUrl1;
      final response=await http.post(Uri.parse('$baseurl2/Editor/AcceptSentProject?sProId=$SentprojectID'),);
      if(response.statusCode==200)
      {
        print('Project Accept By Editor');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text('Uploaded',style: TextStyle(fontFamily: 'BigShotone',fontSize: 20,color: Colors.white,),),
              content: Row(
                children: [
                  Icon(Icons.check, color: Colors.black,size: 30,),
                  SizedBox(width: 8),
                  Text('UPLOADED\nSUCCESSFULLY',style: TextStyle(fontFamily: 'BigShotone',fontSize: 20,color: Colors.white,),),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK',style: TextStyle(fontFamily: 'BigShotone',fontSize: 20,color: Colors.white,),),
                ),
              ],
            );
          },
        );

      }
      else if(response.statusCode==404)
      {
        print('Failed To Accept Project');
      }
      else
      {
        print('Something Went Wrong${response.reasonPhrase}');
      }
    }
    catch(error)
    {
      print('Failed To Accept Project ${error}');
    }

  }
  Future<void> viewSentProject(String movieId) async {
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
        print('Summaryies Data: $summariesData');
        print('Clipssss Data: $clipsData');
        print('ClipsInfo:$clipsInfoList');
        refreshPage();

      } else {
        print('Failed to view sent project: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error viewing sent project: $e');
    }
  }



  @override
  void initState() {
    super.initState();
    print('Title::${widget.moviename}');
    fetchSummary(widget.sentProjectID.toString());
    viewSentProject(widget.MovieID.toString());

  }
  void refreshPage () {
    setState(() {
      summaryText = summariesData.isNotEmpty ? summariesData.last['Summary1'].toString() : '';

    });
  }
//   void refreshPage () {
//     setState(()  {

//
//       if (clipsData.isNotEmpty) {
//         bool isCompoundClip = clipsData[currentClipIndex]['isCompoundClip'];
//         if (isCompoundClip) {
//
//           String startTimeStr = clipsData[currentClipIndex]['Start_time'].trim();
//           String endTimeStr = clipsData[currentClipIndex]['End_time'].trim();
//
//           double startTimeDouble = double.parse(startTimeStr);
//           double endTimeDouble = double.parse(endTimeStr);
//
// // Convert the double values to integers
//           int startTimeInSeconds = startTimeDouble.toInt();
//           int endTimeInSeconds = endTimeDouble.toInt();
//
// // Create Duration objects
//           Duration startTime = Duration(seconds: startTimeInSeconds);
//           Duration endTime = Duration(seconds: endTimeInSeconds);
//
//
//           // Future.delayed(Duration(milliseconds: startTime)); // Delay start
//           // Initialize YoutubePlayerController for each clip
//           controller = YoutubePlayerController(
//             initialVideoId: YoutubePlayer.convertUrlToId(clipsData[currentClipIndex]['Url']) ?? '',
//             flags: YoutubePlayerFlags(
//
//
//                 autoPlay: true,
//                 startAt: startTime.inSeconds
//
//               // End at the clip's end time
//             ),
//           )..addListener(_onControllerStateChanged);
//           //
//
//         }
//
//
//          isPlayerReady = true;
//       }
//
//
//     });
//   }


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
              color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(20),
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Container(
            //       width: 350,
            //       height: 200,
            //       decoration: BoxDecoration(
            //           color: Colors.black,
            //           borderRadius: BorderRadius.circular(10)),
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Stack(
            //           children: [
            //             // Image
            //             //
            //             // isPlayerReady
            //             //     ? YoutubePlayer(
            //             //   controller: controller,
            //             //   showVideoProgressIndicator: true,
            //             //   onReady: () {
            //             //     setState(() {
            //             //       isPlayerReady = true;
            //             //     });
            //             //     print('Player is ready.');
            //             //   },
            //             // )
            //             //     : loadingTextWidget,
            //
            //
            //
            //             // Text in the right bottom corner
            //             // Column(
            //             //   mainAxisAlignment: MainAxisAlignment.end,
            //             //   crossAxisAlignment: CrossAxisAlignment.start,
            //             //   children: [
            //             //     Text(
            //             //       'WAAR',
            //             //       style: TextStyle(
            //             //           color: Colors.white, // Set your desired text color
            //             //           fontSize: 16,
            //             //           fontWeight:
            //             //           FontWeight.bold // Set your desired text size
            //             //       ),
            //             //     ),
            //             //     Text(
            //             //       'Bilal Lashari',
            //             //       style: TextStyle(
            //             //           color: Colors.yellow,
            //             //           fontSize: 10,
            //             //           fontWeight: FontWeight.bold),
            //             //     ),
            //             //     Text(
            //             //       'Writer: Amman',
            //             //       style: TextStyle(
            //             //           color: Colors.yellow,
            //             //           fontSize: 10,
            //             //           fontWeight: FontWeight.bold),
            //             //     ),
            //             //   ],
            //             // ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditorReadingScreen()));
                        },
                        child: Text(
                          'Read',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,fontFamily: 'BigshotOne'),
                        )),
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
                                        builder: (context) =>
                                            WatchingScreen(moviename: widget.moviename,clipsData: clipsData,ClipsInfoList: clipsInfoList,

                                            )));
                              });
                            },
                            child: Text(
                              'Watch',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,fontFamily: 'BigshotOne'),
                            ))),
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
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        summaryText ?? 'Loading summary...',
                        style: TextStyle(fontSize: 20, color: Colors.white,fontFamily: 'BigshotOne',fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow),
                          onPressed: () {
                            AcceptSentProject(widget.sentProjectID.toString());
                          },
                          child: Text(
                            'Upload',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,fontFamily: 'BigshotOne'),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>EditorAddCommentsFroWriterScreen(MovieID: widget.MovieID,sentProjectID: widget.sentProjectID,)));
                          },
                          child: Text(
                            'Rewrite',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,fontFamily: 'BigshotOne'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
//   void _onControllerStateChanged() {
//     String startTimeStr = clipsData[currentClipIndex]['Start_time'].trim();
//     String endTimeStr = clipsData[currentClipIndex]['End_time'].trim();
//
//     double startTimeDouble = double.parse(startTimeStr);
//     double endTimeDouble = double.parse(endTimeStr);
//
// // Convert the double values to integers
//     int startTimeInSeconds = startTimeDouble.toInt();
//     int endTimeInSeconds = endTimeDouble.toInt();
//
// // Create Duration objects
//     Duration startTime = Duration(seconds: startTimeInSeconds);
//     Duration EndTime = Duration(seconds: endTimeInSeconds);
//     final currentTime = controller.value.position;
//     final  endTime = EndTime;
//
//
//
//
//     if (currentTime >= endTime) {
//       if(init)
//         return;
//       init=true;
//
//       // Current clip ended, load next clip
//       if (currentClipIndex < clipsData.length - 1) {
//         currentClipIndex++;
//         controller.load(clipsData[currentClipIndex]['Url']);
//         controller.seekTo(startTime);
//         init=false;
//       } else {
//         currentClipIndex=0;
//         controller.load(clipsData[currentClipIndex]['Url']);
//         controller.seekTo(startTime);
//         init=false;
//         // All clips played
//         // You can add logic here for what to do when all clips are played
//       }
//     }
//   }
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
}