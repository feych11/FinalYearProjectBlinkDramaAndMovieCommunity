import 'package:finalsemproject/API.dart';
import 'package:finalsemproject/Screens/CoumpundAndSimpleClipsScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:finalsemproject/Screens/VideoClip.dart';
import 'dart:math';

class VideoPlayerScreen extends StatefulWidget {
  final String videoId;
  final String thumbnailUrl;
  final String title;
  final int? id;
  final int ?Movie_ID;
  final int ?Editor_ID;
  final String ?Writer_ID;
  final String ?title1;
  final String ?summary;
  final String ?Type;
  final int ?Episode;

  const VideoPlayerScreen({Key? key, required this.videoId,required this.thumbnailUrl,required this.title,this.id,
    this.Movie_ID,
    this.Editor_ID,
    this.Writer_ID,
    this.title1,
    this.Type,
    this.Episode,
    this.summary}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;
  double _startValue = 0.0;
  double _endValue = 0.0;
  int maxValue = 20;
  bool _isPlayerReady = false;
  RangeValues _currentRangeValues = const RangeValues(0.0, 0.0);
  TextEditingController DesCon = TextEditingController();
  List<VideoClip> videoClips = [];
  bool isCompound = true;
  bool SimpleClip=true;
  List<Map<String, String>> clipsInfoList = [];
  @override
  void initState() {
    super.initState();
    print('Sent Perposal id: ${widget.id}');
    print('Movie ID: ${widget.Movie_ID}');
    print('Editor ID: ${widget.Editor_ID}');
    print('Writer ID: ${widget.Writer_ID}');
    print('Title: ${widget.title1}');
    print('Summary: ${widget.summary}');
    print('Type: ${widget.Type}');
    print('Episode: ${widget.Episode}');
    String videoIdAsString = widget.videoId.toString();

    _controller = YoutubePlayerController(
      initialVideoId: videoIdAsString,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    // Add this listener to print the duration when the player is ready
    _controller.addListener(() {
      if (_controller.value.isReady && !_isPlayerReady) {
        print('Duration: ${_controller.metadata.duration}');
        setState(() {
          _endValue = _controller.metadata.duration?.inSeconds.toDouble() ?? 0.0;
          _currentRangeValues = RangeValues(0.0, _endValue);
          _isPlayerReady = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onCompoundClip()  {
    videoClips.add(VideoClip(
      start_time: _currentRangeValues.start.toDouble(),
      end_time: _currentRangeValues.end.toDouble(),
      url: widget.videoId,
      isCompoundClip: isCompound,
      SimpleClip:false,
      thumbnailUrl: widget.thumbnailUrl,
      title: widget.title,
      Description: DesCon.text


    ));
    print('COde ok');
  }
  void Addingclipinfo(){

    for(var clip in videoClips)
    {
      if(clip.isCompoundClip)
      {
        clipsInfoList.add(
            {
              'Start_time':clip.start_time.toString(),
              'End_time':clip.end_time.toString(),
              'Url':widget.videoId
            });
      }
    }
  }

  void _onSimpleClip()  {
    videoClips.add(VideoClip(
      start_time: _currentRangeValues.start.toDouble(),
      end_time: _currentRangeValues.end.toDouble(),
      url: widget.videoId,
      isCompoundClip: false,
      SimpleClip:SimpleClip,
      thumbnailUrl: widget.thumbnailUrl,
      title: widget.title,
      Description: DesCon.text


    ));
    print('COde ok');
  }
  String _formatDuration(int seconds) {
    Duration duration = Duration(seconds: seconds);
    String formattedDuration = [
      if (duration.inHours > 0) '${duration.inHours}:',
      '${(duration.inMinutes % 60).toString().padLeft(2, '0')}:',
      '${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
    ].join('');
    return formattedDuration;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Video Screen',style: TextStyle(fontSize: 20,fontFamily: 'Rye',fontWeight: FontWeight.bold,color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,

          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,

                    border: Border.all(
                      color: Colors.white,
                      width: 6,
                    ),
                  ),
                  child: YoutubePlayer(

                    controller: _controller,
                    showVideoProgressIndicator: true,
                    onReady: () {
                      print('Player is ready.');
                    },
                  ),
                ),
                SizedBox(height: 20),
                SliderTheme(
                  // Customization of the SliderTheme
                  // based on individual definitions
                  // (see rangeSliders in _RangeSliderSampleState)
                  data: SliderTheme.of(context).copyWith(
                    showValueIndicator: ShowValueIndicator.always,
                    // Customize other properties as needed
                  ),
                  child: RangeSlider(
                    values: _currentRangeValues,
                    min: 0, // Assuming the minimum value is 0
                    max: _controller.metadata.duration.inSeconds.toDouble(),
                    // divisions: _controller.metadata.duration.inSeconds,
                    divisions: null,
                    labels: RangeLabels(
                      _formatDuration(_currentRangeValues.start.round()),
                      _formatDuration(_currentRangeValues.end.round()),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _currentRangeValues = values;
                      });
                      // Seek the video to the start position of the selected range
                      _controller.seekTo(Duration(seconds: values.start.toInt()));
                    },
                  ),
                ),

                SizedBox(height: 20),
                Container(
                  width: 300,
                  child: TextField(
                    controller: DesCon,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.black)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'Description',
                      labelStyle: TextStyle(fontFamily: 'Rye', fontWeight: FontWeight.bold, color: Colors.black),
                      hintText: 'Description',
                      hintStyle: TextStyle(fontFamily: 'Rye', fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        setState(() {
                          _onSimpleClip();
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black), // Change the color to red
                      ),
                      child: Text('Make Clip', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Rye',color: Colors.white)),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isCompound = true;
                          _onCompoundClip();
                        });
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.black)
                      ),
                      child: Text('Compound Clip', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Rye',color: Colors.white)),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                ElevatedButton(onPressed: (){
                  print(videoClips);
                  for (var clip in videoClips) {
                    print('Start Time: ${clip.start_time}');
                    print('End Time: ${clip.end_time}');
                    print('URL: ${clip.url}');
                    print('Is Compound Clip: ${clip.isCompoundClip}');
                    print('Is Simple Clip: ${clip.SimpleClip}');
                    print('Thumbnail url: ${clip.thumbnailUrl}');
                    print('Thumbnail url: ${clip.Description}');
                    print('');
                    print('');
                  }
                  Addingclipinfo();
                  print('AddingClipinfo: ${clipsInfoList}');
                  print('Sent Perosal id: ${widget.id}');
                  print('MOvie ID: ${widget.Movie_ID}');
                  print('Writer ID: ${widget.Writer_ID}');
                  print('Editor id: ${widget.Editor_ID}');
                  print('Title: ${widget.title1}');
                  print('Summary: ${widget.summary}');

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CoumpundAndSimpleClipsScreen(Episode: widget.Episode,ClipsInfoList:clipsInfoList,videoId: widget.videoId,videoClips: videoClips,id: widget.id,Movie_ID: widget.Movie_ID,Writer_ID: widget.Writer_ID,Editor_ID: widget.Editor_ID,title1: widget.title1,Type: widget.Type,summary: widget.summary,)));
                },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.black)),
                    child: Text('Clips Screen',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Rye',color: Colors.white),))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
