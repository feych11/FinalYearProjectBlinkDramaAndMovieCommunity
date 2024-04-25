// import 'dart:async';
//
// import 'package:finalsemproject/Screens/ReaderLoginScreen.dart';
// import 'package:finalsemproject/Screens/WriterLoginScreen.dart';
// import 'package:flutter/material.dart';
// class Splashscreen extends StatefulWidget {
//   const Splashscreen({super.key});
//
//   @override
//   State<Splashscreen> createState() => _SplashscreenState();
// }
//
// class _SplashscreenState extends State<Splashscreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     Timer(Duration(seconds: 5), () {
//
//       Navigator.push(context, MaterialPageRoute(builder: (context)=>WriterLoginscreen()));
//     });
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFFFD700),
//       body: SafeArea(child: Center(child: Image.asset('Images/splash1.png',height: 300,width: 800,))),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class VideoClip {
  final String videoUrl;
  final Duration startTime;
  final Duration endTime;

  VideoClip({required this.videoUrl, required this.startTime, required this.endTime});
}

class VideoPlayerPage extends StatefulWidget {
  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late YoutubePlayerController _controller;
  List<VideoClip> clips = [
    VideoClip(videoUrl: 'https://www.youtube.com/watch?v=72eQ0seOP1k', startTime: Duration(seconds: 10), endTime: Duration(seconds: 30)),
    VideoClip(videoUrl: 'https://www.youtube.com/watch?v=72eQ0seOP1k', startTime: Duration(seconds: 5), endTime: Duration(seconds: 20)),
    VideoClip(videoUrl: 'https://www.youtube.com/watch?v=72eQ0seOP1k', startTime: Duration(seconds: 50), endTime: Duration(seconds: 70)),
    // Add more clips as needed
  ];
  int currentClipIndex = 0;
  bool init=false;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(clips[currentClipIndex].videoUrl)!,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        startAt: clips[currentClipIndex].startTime.inSeconds,
      ),
    )..addListener(_onControllerStateChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
        ),
      ),
    );
  }

  void _onControllerStateChanged() {
    final currentTime = _controller.value.position;
    final endTime = clips[currentClipIndex].endTime;

    if (currentTime >= endTime) {
      if(init)
        return;
      init=true;

      // Current clip ended, load next clip
      if (currentClipIndex < clips.length - 1) {
        currentClipIndex++;
        _controller.load(clips[currentClipIndex].videoUrl);
        _controller.seekTo(clips[currentClipIndex].startTime);
        init=false;
      } else {
        currentClipIndex=0;
        _controller.load(clips[currentClipIndex].videoUrl);
        _controller.seekTo(clips[currentClipIndex].startTime);
        init=false;
        // All clips played
        // You can add logic here for what to do when all clips are played
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
