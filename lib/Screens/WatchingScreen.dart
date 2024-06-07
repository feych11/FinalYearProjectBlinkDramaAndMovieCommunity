import 'package:finalsemproject/Screens/ReaderBottomNavScreen.dart';
import 'package:finalsemproject/Screens/ReaderLoginScreen.dart';
import 'package:finalsemproject/Screens/ReaderSelectInterestsScreen.dart';
import 'package:finalsemproject/Screens/ReaderSubcriptionScreen.dart';
import 'package:finalsemproject/Screens/WriterAccountSettingScreen1.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:async';
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
  int currentClipIndex = 0;
  bool isClipInitialized = false;
  bool isPlayerReady = false;
  Timer? timer;
  Timer?timer1;
  bool init=false;
  List<VideoClip> clips = [];
  @override
  void initState() {
    super.initState();
    print('ISCompoundCLips Info:${widget.ClipsInfoList}');
    print('MovieName::: ${widget.moviename}');
    nonCompoundVideoWidgets = _buildNonCompoundVideos();
    //refreshPage();
    print('INFO  CLIPSSSSS:${widget.clipsData}');
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
      for (var element in clips) {print('start ${element.StartTime.inSeconds} end :: ${element.EndTime.inSeconds}');}
      //  clips.clear();
      // clips = [
      //    VideoClip(videoUrl: 'https://www.youtube.com/watch?v=72eQ0seOP1k', StartTime: Duration(seconds: 10), EndTime: Duration(seconds: 30)),
      //    VideoClip(videoUrl: 'https://www.youtube.com/watch?v=72eQ0seOP1k', StartTime: Duration(seconds: 5), EndTime: Duration(seconds: 20)),
      //    VideoClip(videoUrl: 'https://www.youtube.com/watch?v=72eQ0seOP1k', StartTime: Duration(seconds: 50), EndTime: Duration(seconds: 70)),
      //    // Add more clips as needed
      //  ];
      if (clips.isNotEmpty) {
        try {
          controller = YoutubePlayerController(
            initialVideoId: YoutubePlayer.convertUrlToId(clips[currentClipIndex].videoUrl)!,
            flags: YoutubePlayerFlags(
              autoPlay: true,
              startAt: clips[currentClipIndex].StartTime.inSeconds,
            ),
          )..addListener(_onControllerStateChanged);
        } catch (e) {
          print('Error initializing YouTube player: $e');
        }
        timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
          if (controller.value.isReady && controller.value.isPlaying) {
            print('Current position: ${controller.value.position}');
          }
        });

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
        timer1 = Timer.periodic(Duration(seconds: 1), (Timer t) {
          if (controllerr.value.isReady && controllerr.value.isPlaying) {
            print('Current position: ${controllerr.value.position}');
          }
        });


        // Add padding around each video widget and add a text widget after each clip
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                YoutubePlayer(controller: controllerr),
                const SizedBox(height: 10), // Add gap between video and text
                Text(
                  '$description - Part ${i + 1}', // Display movie name
                  style: const TextStyle(
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
                  )),

              ListTile(
                title: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ReaderBottomNavScreen()));
                  },
                  child: const Text(
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ReaderSubcriptionScreen()));
                  },
                  child: const Text(
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ReaderSelectInterestsScreen()));
                  },
                  child: const Text(
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
                title: const Text(
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const WriterAccountSettingScreen1()));
                  },
                  child: const Text(
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const ReaderLoginScreen()));
                },
                child: ListTile(
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
                          color: Colors.red),
                    ),
                  ),
                ),
              ),
              // Add more ListTiles for additional items in the drawer
            ],
          ),
        ),
        appBar: AppBar(title: const Text('Watching',style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white,
            fontFamily: 'BigShotone'),),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Stack(children: [

          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('Images/bgimg1.png'), // Your background image
                fit: BoxFit.cover,
              ),
            ),
          ),

          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              const SizedBox(height: 10,),
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
                  gradient: const LinearGradient(
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
                          child: const Text('Read',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          onTap: (){

                          },
                          child: const Text('Watch',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),)),
                    )
                  ],),

              ),
              const SizedBox(height: 30,),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20), // Adjust padding as needed
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children:

                    nonCompoundVideoWidgets,
                  ),
                ),
              ),

              const SizedBox(height: 10,),


            ],),
          ),
        ],)
    );
  }
  void _onControllerStateChanged() {
    final currentTime = controller.value.position;
    final endTime = clips[currentClipIndex].EndTime;

    if (currentTime >= endTime && !isClipInitialized) {
      isClipInitialized = true;

      if (currentClipIndex < clips.length - 1) {
        currentClipIndex++;
      } else {
        currentClipIndex = 0;
      }

      controller.load(YoutubePlayer.convertUrlToId(clips[currentClipIndex].videoUrl)!,
          startAt: clips[currentClipIndex].StartTime.inSeconds);
      isClipInitialized = false;
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
