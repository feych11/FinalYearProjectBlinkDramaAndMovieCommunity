import 'package:finalsemproject/API.dart';
import 'package:finalsemproject/Screens/EditorReadingScreen.dart';
import 'package:finalsemproject/Screens/ReaderBottomNavScreen.dart';
import 'package:finalsemproject/Screens/ReaderLoginScreen.dart';
import 'package:finalsemproject/Screens/ReaderSelectInterestsScreen.dart';
import 'package:finalsemproject/Screens/ReaderSubcriptionScreen.dart';
import 'package:finalsemproject/Screens/ReadingScreen.dart';
import 'package:finalsemproject/Screens/WriterAccountSettingScreen1.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class VideoClip {
  final String videoUrl;
  final Duration StartTime;
  final Duration EndTime;

  VideoClip({required this.videoUrl, required this.StartTime, required this.EndTime});
}

class WatchingScreen extends StatefulWidget {
  String?moviename;
  final List<Map<String,dynamic>> ?clipsData;
  final List<Map<String,dynamic>>?ClipsInfoList;

  WatchingScreen({super.key,
    this.clipsData,
    this.ClipsInfoList,
    this.moviename

  });

  @override
  State<WatchingScreen> createState() => _WatchingScreenState();
}

class _WatchingScreenState extends State<WatchingScreen> {
  late List<Widget> nonCompoundVideoWidgets;
  late YoutubePlayerController controller;
  bool isPlayerReady = false;
  int currentClipIndex = 0;
  bool init=false;
  List<VideoClip> clips = [];
  @override
  void initState() {
    super.initState();
    print('ISCompoundCLips Info:${widget.ClipsInfoList}');
    print('MovieName::: ${widget.moviename}');
    nonCompoundVideoWidgets = _buildNonCompoundVideos();
    //refreshPage();
    print('INFO  CLIPSSSSS:'+widget.clipsData.toString());
    for(var clip in widget.clipsData!)
    {
      print('CLips isCompund:');
    }

    if (widget.ClipsInfoList != null) {
      for (var isCompoundclipData in widget.ClipsInfoList!) {
        //bool isCompound = clipData['isCompoundClip'] ?? false;

        String videoUrl = "https://www.youtube.com/watch?v="+ isCompoundclipData['Url'] ?? '';
        String startTimeStr = isCompoundclipData['Start_time'].trim();
        String endTimeStr = isCompoundclipData['End_time'].trim();

        double startTimeDouble = double.parse(startTimeStr);
        double endTimeDouble = double.parse(endTimeStr);

        int startTimeInSeconds = startTimeDouble.toInt();
        int endTimeInSeconds = endTimeDouble.toInt();

        Duration startTime = Duration(seconds: startTimeInSeconds);
        Duration endTime = Duration(seconds: endTimeInSeconds);

        // clips.add(VideoClip(videoUrl: videoUrl, StartTime: startTime, EndTime: endTime));
        clips.add(VideoClip(videoUrl: videoUrl, StartTime: Duration(seconds: startTimeInSeconds), EndTime: Duration(seconds: endTimeInSeconds)));

      }
      print('CLIPS LIST :');
      clips.forEach((element) {print('start ${element.StartTime.inSeconds} end :: ${element.EndTime.inSeconds}');});
      //  clips.clear();
      // clips = [
      //    VideoClip(videoUrl: 'https://www.youtube.com/watch?v=72eQ0seOP1k', StartTime: Duration(seconds: 10), EndTime: Duration(seconds: 30)),
      //    VideoClip(videoUrl: 'https://www.youtube.com/watch?v=72eQ0seOP1k', StartTime: Duration(seconds: 5), EndTime: Duration(seconds: 20)),
      //    VideoClip(videoUrl: 'https://www.youtube.com/watch?v=72eQ0seOP1k', StartTime: Duration(seconds: 50), EndTime: Duration(seconds: 70)),
      //    // Add more clips as needed
      //  ];
      if (clips.isNotEmpty) {
        controller = YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(clips[currentClipIndex].videoUrl)!,
          flags: YoutubePlayerFlags(
            // autoPlay: true,
            autoPlay: false,
            startAt: clips[currentClipIndex].StartTime.inSeconds,
          ),
        )..addListener(_onControllerStateChanged);
      }

    }



  }

  List<Widget> _buildNonCompoundVideos() {
    List<Widget> widgets = [];

    for (var i = 0; i < widget.clipsData!.length; i++) {
      var clip = widget.clipsData![i];
      bool isCompound = clip['isCompoundClip'] ?? false;

      if (!isCompound) {
        String videoUrl = clip['Url'] ?? '';
        String description=clip['Description']??'';
        double startAt = double.parse(clip['Start_time'] ?? '0.0');
        double endAt = double.parse(clip['End_time'] ?? '0.0');
        YoutubePlayerController controllerr = YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(videoUrl) ?? '',
          flags: YoutubePlayerFlags(
            autoPlay:false,
            startAt: startAt.toInt(),
            endAt: endAt.toInt(),
          ),
        );

        // Add padding around each video widget and add a text widget after each clip
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                YoutubePlayer(controller: controllerr),
                SizedBox(height: 10), // Add gap between video and text
                Text(
                  '${description} - Part ${i + 1}', // Display movie name
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'BigshotOne'
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }

    return widgets;
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
              onTap: () {
                // Add your action when the item is tapped
                Navigator.pop(context); // Close the drawer
              },
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
      appBar: AppBar(title: Text('Watching',style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Colors.white,
          fontFamily: 'BigShotone'),),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Stack(children: [

        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Images/bgimg1.png'), // Your background image
              fit: BoxFit.cover,
            ),
          ),
        ),

        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 350,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: Colors.white,
                        width: 4,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        //Image

                        // isPlayerReady
                        //     ?
                        YoutubePlayer(
                          controller: controller,
                          showVideoProgressIndicator: true,
                          // // onReady: () {
                          // //   setState(() {
                          // //     isPlayerReady = true;
                          // //   });
                          //   print('Player is ready.');
                          // },
                        )
                        // : loadingTextWidget,



                        // Text in the right bottom corner
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text(
                        //       'WAAR',
                        //       style: TextStyle(
                        //           color: Colors.white, // Set your desired text color
                        //           fontSize: 16,
                        //           fontWeight:
                        //           FontWeight.bold // Set your desired text size
                        //       ),
                        //     ),
                        //     Text(
                        //       'Bilal Lashari',
                        //       style: TextStyle(
                        //           color: Colors.yellow,
                        //           fontSize: 10,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //     Text(
                        //       'Writer: Amman',
                        //       style: TextStyle(
                        //           color: Colors.yellow,
                        //           fontSize: 10,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
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
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.black, Colors.black, Colors.yellow, Colors.yellow],
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
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Text('Read',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: (){

                        },
                        child: Text('Watch',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),)),
                  )
                ],),

            ),
            SizedBox(height: 30,),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20), // Adjust padding as needed
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children:

                  nonCompoundVideoWidgets,
                ),
              ),
            ),

            SizedBox(height: 10,),


          ],),
        ),
      ],)
    );
  }
  void _onControllerStateChanged() {
    final currentTime = controller.value.position;
    final endTime = clips[currentClipIndex].EndTime;
    print('current :${currentTime} end: ${endTime}');

    if (currentTime >= endTime) {
      controller.pause();
      print('Matched :: Index ${currentClipIndex}:: start ${clips[currentClipIndex].StartTime.inSeconds} :: end ${clips[currentClipIndex].EndTime.inSeconds}');
      if (init) {
        return;
      }
      init = true;

      // Current clip ended, load next clip
      if (currentClipIndex < clips.length - 1) {
        currentClipIndex++;
        controller.load(clips[currentClipIndex].videoUrl);
        controller.seekTo(clips[currentClipIndex].StartTime);
        controller.play();



        init = false;
      } else {
        controller.pause();
        // currentClipIndex = 0;
        // controller.load(clips[currentClipIndex].videoUrl);
        // controller.seekTo(clips[currentClipIndex].StartTime);
        // init = false;
        // All clips played
        // You can add logic here for what to do when all clips are played
      }
    }
  }

  @override
  void dispose1() {
    controller.dispose();
    super.dispose();
  }
  @override
  void dispose() {
    for (var widget in nonCompoundVideoWidgets) {
      if (widget is YoutubePlayer) {
        widget.controller.dispose();
      }
    }
    super.dispose();
  }
}
