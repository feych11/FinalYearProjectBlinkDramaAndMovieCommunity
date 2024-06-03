import 'dart:convert';
import 'dart:ui';
import 'package:finalsemproject/API.dart';
import 'package:finalsemproject/Screens/WriterMakingClipsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart'as http;
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:finalsemproject/Screens/VideoClip.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';



List<VideoClip1> clips = [];
class VideoClip1 {
  final String videoUrl;
  final Duration StartTime;
  final Duration EndTime;

  VideoClip1({required this.videoUrl, required this.StartTime, required this.EndTime});
}
class CoumpundAndSimpleClipsScreen extends StatefulWidget {
  final List<VideoClip> videoClips;

  final List<Map<String,dynamic>>?ClipsInfoList;
  final String? videoId;
  final int? id;
  final int ?Movie_ID;
  final int ?Editor_ID;
  final String ?Writer_ID;
  final String ?title1;
  final String ?writerName;
  final String ?Type;
  // final String ?status;
  // final String ?imagePath;
  final String ?summary;
  final int ?Episode;
  final int ? VideoIDAsString;



  const CoumpundAndSimpleClipsScreen({Key? key, required this.videoClips,

    this.videoId,
    this.id,
    this.Movie_ID,
    this.Editor_ID,
    this.Writer_ID,
    this.title1,
    this.writerName,
    this.Type,
    this.VideoIDAsString,
    this.ClipsInfoList,
    //this.status,
    this.summary,
    this.Episode,
    //this.imagePath,
  }) : super(key: key);

  @override
  State<CoumpundAndSimpleClipsScreen> createState() => _CoumpundAndSimpleClipsScreenState();
}

class _CoumpundAndSimpleClipsScreenState extends State<CoumpundAndSimpleClipsScreen> {
  final List<Map<String,dynamic>>ClipsInfoList2=[];
  int currentClipIndex = 0;

  bool isClipInitialized = false;

  late YoutubePlayerController controller;
  final Color Green  = Color(0xFF4FAA6D);
  int? episode1;
  int? id1;
  String? writerID1;
  int? movieID1;
  String? summary1;
  String? title2;
  int? editorID1;
  String? type1;






  Future<void> printSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
     episode1 = prefs.getInt('Episode');
    id1 = prefs.getInt('id');
    writerID1 = prefs.getString('Writer_ID');
    movieID1 = prefs.getInt('Movie_ID');
    summary1 = prefs.getString('summary');
    title2 = prefs.getString('title');
    editorID1 = prefs.getInt('Editor_ID');
    type1 = prefs.getString('Type');

    print('Episodeeee: $episode1');
    print('IDeee: $id1');
    print('Writer_IDeee: $writerID1');
    print('Movie_IDeee: $movieID1');
    print('Summary: $summary1');
    print('Title: $title2');
    print('Editor_ID: $editorID1');
    print('Type: $type1');
  }

  @override
  void initState() {
    super.initState();
    printSharedPreferences();
    if(widget.ClipsInfoList!=null)
    {
      for (var isCompoundclip in widget.ClipsInfoList!)
      {
        String videoUrl="https://www.youtube.com/watch?v="+isCompoundclip['Url']??'';
        String startTimeStr = isCompoundclip['Start_time'].trim();
        String endTimeStr = isCompoundclip['End_time'].trim();

        double startTimeDouble = double.parse(startTimeStr);
        double endTimeDouble = double.parse(endTimeStr);

        int startTimeInSeconds = startTimeDouble.toInt();
        int endTimeInSeconds = endTimeDouble.toInt();


        clips.add(VideoClip1(videoUrl: videoUrl, StartTime: Duration(seconds: startTimeInSeconds), EndTime: Duration(seconds: endTimeInSeconds)));

      }
      print('CLIPS LIST :');
      clips.forEach((element) {print('start ${element.StartTime.inSeconds} end :: ${element.EndTime.inSeconds}');});
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
    String videoIdAsString = widget.videoId.toString();
    print('Data: ' + widget.videoClips.toString());
    print('Clipf Info: ${widget.ClipsInfoList}');
    for (var clip in widget.videoClips)
    {
      print('Start Time: ${clip.start_time}');
      print('End Time: ${clip.end_time}');
      print('URL: ${clip.url}');
      print('Is Compound Clip: ${clip.isCompoundClip}');
      print('Is Simple Clip: ${clip.SimpleClip}');
      print('ThumbnailURL: ${clip.thumbnailUrl}');
      print('Title: ${clip.title}');
      print('Description: ${clip.Description}');
      print('');

    }
    for(var clips in widget.videoClips)
    {
      if(clips.isCompoundClip)
      {
        ClipsInfoList2.add(
            {
              'Start_time':clips.start_time.toString(),
              'End_time':clips.end_time.toString(),
              'Url':widget.videoId

            });
      }
    }
    print('ClipsInfo List 2: ${ClipsInfoList2}');
    print('ID: ${widget.id}');
    print('URL: ${widget.videoId}');
    print('Writer ID: ${widget.Writer_ID}');
    print('Movie ID: ${widget.Movie_ID}');
    print('Type: ${widget.Type}');
    print('Summary: ${widget.summary}');
    print('Title: ${widget.title1}');
    print('Editor ID: ${widget.Editor_ID}');
    print('Episode No: ${widget.Episode}');

  }

  Future<void> sendProject({
    required int? id1,
    required String? writerID1,
    required int? movieID1,
    String? title1,
    required String? summary1,
    required String? type1,
    required int? editorID1,
    required int?episode1,

    required List<Map<String, dynamic>> clips, // Directly accept the list of clips
  }) async {
    final String baseUrl2 = APIHandler.baseUrl1; // Replace with your API base URL
    final String endpoint = '$baseUrl2/Writer/SentProject'; // Replace with your API endpoint

    try {
      final Uri url = Uri.parse('$endpoint');
      final Map<String, dynamic> data = {
        'SentProposal_ID': id1,
        'Writer_ID': writerID1,
        'Movie_ID': movieID1,
        'Type':type1,
        'Summary': summary1,
        'Editor_ID': editorID1,
        'Episode':episode1,
        'Clips': clips, // Pass the clips directly
      };
      print('DataAAAAAA: $data');
      final http.Response response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // Project sent successfully
        print(response.body);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text('Sent Project',style: TextStyle(fontFamily: 'BigShotone',fontSize: 20,color: Colors.white,),),
              content: Row(
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
                  child: Text('OK',style: TextStyle(fontFamily: 'BigShotone',fontSize: 20,color: Colors.white,),),
                ),
              ],
            );
          },
        );
        // Handle navigation or UI updates as needed
      } else {
        // Project sending failed
        print('Failed to send project');
        // Handle error or display message to user
      }
    } catch (error) {
      // Error occurred during the API call
      print('Error sending project: $error');
      // Handle error or display message to user
    }
  }


  void _showVideoAlertDialog1(VideoClip clip) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: YoutubePlayer.convertUrlToId(widget.videoId.toString()) ?? '',
                flags: YoutubePlayerFlags(
                    autoPlay: true,
                    mute: false,
                    endAt: clip.end_time.toInt(),
                    startAt: clip.start_time.toInt()// Convert to int
                  // Convert to int
                ),
              ),
              showVideoProgressIndicator: true,
              onReady: () {
                print('Player is ready.');
              },
            ),
          ),
        );
      },
    );
  }



  void _showVideoAlertDialog(VideoClip clip) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: YoutubePlayer.convertUrlToId(widget.videoId.toString()) ?? '',
                flags: YoutubePlayerFlags(
                    autoPlay: true,
                    mute: false,
                    endAt: clip.end_time.toInt(),
                    startAt: clip.start_time.toInt()// Convert to int
                  // Convert to int
                ),
              ),
              showVideoProgressIndicator: true,
              onReady: () {
                print('Player is ready.');
              },
            ),
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    List<VideoClip> compoundClips = widget.videoClips.where((clip) => clip.isCompoundClip).toList();
    List<VideoClip> simpleClips = widget.videoClips.where((clip) => !clip.isCompoundClip).toList();

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        centerTitle: true,
        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Making Clips',
              style: TextStyle(fontFamily: 'Rye', fontWeight: FontWeight.bold, color: Colors.white),
            ),
            InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>WriterMakingClipsScreen()));
                },
                child: Icon(Icons.backspace,size: 20,color:Colors.white,)),
          ],),
        backgroundColor: Colors.black,
      ),
      body:

      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(

          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [
              SizedBox(height: 20,),
              Center(
                  child: Container(

                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(child: Text('Compound Clip',style: TextStyle(fontFamily: 'BigshotOne',color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                  )
              ),
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

              SizedBox(height: 70,),
              Center(
                  child: Container(

                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(child: Text('Simple Clip',style: TextStyle(fontFamily: 'BigshotOne',color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                  )
              ),
              SizedBox(height: 10,),
              // Add some gap between compoundClips and simpleClips
              Expanded(

                child: ListView.builder(
                  itemCount: simpleClips.length,
                  itemBuilder: (context, index) {
                    final VideoClip clip = simpleClips[index];
                    return Container(
                      decoration: BoxDecoration(

                      ),
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          //borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap:(){
                                  print('CLips KI info: '+clip.start_time.toString());
                                  print('CLIPS KI Zaida Info:  '+clip.end_time.toString());
                                  print('CLIPS KI URL Info:  '+clip.thumbnailUrl);
                                  print('CLIPS KI URL Infoooooo:  '+clip.title);
                                  print('Clips Ki Description: ${clip.Description}');
                                  print('CLIPS KI URL Info:  '+widget.VideoIDAsString.toString());
                                  print('URL: ${widget.videoId}');


                                  _showVideoAlertDialog(clip);
                                },
                                child: Image.network(
                                  clip.thumbnailUrl, // Use the thumbnail URL for the image
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                ),
                                child: Column(
                                  children: [

                                    SizedBox(height: 13),
                                    Text('Title:   ${title2}',style: TextStyle(fontSize: 20,fontFamily: 'BigshotOne',color: Colors.white),
                                      maxLines: 2, // Adjust the number of lines as needed
                                      overflow: TextOverflow.ellipsis,),
                                    SizedBox(height: 13),
                                    Text(
                                      'Is Simple Clip: ${clip.SimpleClip}',
                                      style: TextStyle(

                                        fontFamily: 'BigshotOne',
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(height: 13),
                                    Text(
                                      'Description: ${clip.Description}',
                                      style: TextStyle(

                                        fontFamily: 'BigshotOne',
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 40,), // Add some gap here
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Center(
                child: ElevatedButton(

                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.black)),
                  onPressed: () {
                    print('MovieIDDDDD:  ${widget.Movie_ID}');

                    var clipsData = widget.videoClips.map((clip) => {

                      'Url': clip.url,
                      'isCompoundClip': clip.isCompoundClip,
                      'Title': clip.title,
                      'Start_Time': clip.start_time,
                      'End_Time': clip.end_time,
                      'Description':clip.Description
                    }).toList();
                    // Print clipsData before sending it to the API
                    print('Clips Data: $clipsData');

                    sendProject(
                      id1: id1,
                      writerID1: writerID1,
                      movieID1: movieID1,
                      type1: type1,
                      summary1: summary1,
                      editorID1: editorID1,
                      episode1:episode1,

                      clips: clipsData,
                    );
                  },
                  child: Text(
                    'Sent Project',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'BigshotOne',
                    ),
                  ),
                ),
              ),


            ],
          ),

        ),

      ),


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
}