import 'dart:convert';
import 'dart:ui';
import 'package:finalsemproject/API.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart'as http;
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:finalsemproject/Screens/VideoClip.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
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
    //this.imagePath,
  }) : super(key: key);

  @override
  State<CoumpundAndSimpleClipsScreen> createState() => _CoumpundAndSimpleClipsScreenState();
}

class _CoumpundAndSimpleClipsScreenState extends State<CoumpundAndSimpleClipsScreen> {
  final List<Map<String,dynamic>>ClipsInfoList2=[];
  int currentClipIndex = 0;
  bool init=false;
  List<VideoClip1> clips = [];
  late YoutubePlayerController controller;
  final Color Green  = Color(0xFF4FAA6D);


  @override
  void initState() {
    super.initState();
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

        Duration startTime = Duration(seconds: startTimeInSeconds);
        Duration endTime = Duration(seconds: endTimeInSeconds);
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

  }
  Future<void> sendProject({
    required int? sentProposalId,
    required String? writerId,
    required int? movieId,
     String? title1,
    required String? summary,
    required String? type,
    required int? editorId,
    required List<Map<String, dynamic>> clips, // Directly accept the list of clips
  }) async {
    final String baseUrl2 = APIHandler.baseUrl1; // Replace with your API base URL
    final String endpoint = '$baseUrl2/Writer/SentProject'; // Replace with your API endpoint

    try {
      final Uri url = Uri.parse('$endpoint');
      final Map<String, dynamic> data = {
        'SentProposal_ID': sentProposalId,
        'Writer_ID': writerId,
        'Movie_ID': movieId,
        'Type':type,
        'Summary': summary,
        'Editor_ID': editorId,
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
                    Navigator.of(context).pop();
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
        title: Text(
          'Making Clips',
          style: TextStyle(fontFamily: 'Rye', fontWeight: FontWeight.bold, color: Colors.white),
        ),
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
                                    Text('Title:   ${widget.title1}',style: TextStyle(fontSize: 20,fontFamily: 'BigshotOne',color: Colors.white),
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
                    }).toList();
                    // Print clipsData before sending it to the API
                    print('Clips Data: $clipsData');

                    sendProject(
                      sentProposalId: widget.id,
                      writerId: widget.Writer_ID,
                      movieId: widget.Movie_ID,
                      type: widget.Type,
                      summary: widget.summary,
                      editorId: widget.Editor_ID,
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
}