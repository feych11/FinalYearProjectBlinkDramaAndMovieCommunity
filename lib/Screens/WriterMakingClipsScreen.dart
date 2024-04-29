import 'package:finalsemproject/Screens/WriterVideoPlayerScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:finalsemproject/Models/YouTubeApi.dart';
import 'dart:convert';

class YouTubeVideo {
  final String id; // Add id field
  final String title;
  final String description;
  final String thumbnailUrl;

  YouTubeVideo({
    required this.id, // Update constructor
    required this.title,
    required this.description,
    required this.thumbnailUrl,
  });

  factory YouTubeVideo.fromJson(Map<String, dynamic> json) {
    // Extract the video id based on the type of video (playlist or video)
    String videoId = '';
    if (json['id']['kind'] == 'youtube#video') {
      videoId = json['id']['videoId'];
    } else if (json['id']['kind'] == 'youtube#playlist') {
      videoId = json['id']['playlistId'];
    }
    return YouTubeVideo(
      id: videoId, // Assign id field
      title: json['snippet']['title'],
      description: json['snippet']['description'],
      thumbnailUrl: json['snippet']['thumbnails']['medium']['url'],
    );
  }
}

class WriterMakingClipsScreen extends StatefulWidget {
  final int? id;
  final int ?Movie_ID;
  final int ?Editor_ID;
  final String ?Writer_ID;
  final String ?title;
  final String ?writerName;
  final String ?Type;
  final String ?status;
  final String ?imagePath;
  final String ?summary;

  const WriterMakingClipsScreen({Key? key,
    this.id,
    this.Movie_ID,
    this.Editor_ID,
    this.Writer_ID,
    this.title,
    this.writerName,
    this.Type,
    this.status,
    this.summary,
    this.imagePath,}) : super(key: key);

  @override
  State<WriterMakingClipsScreen> createState() => _WriterMakingClipsScreenState();
}

class _WriterMakingClipsScreenState extends State<WriterMakingClipsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<YouTubeVideo> _videos = [];
  bool _loading = false;
  String _errorMessage = '';
  @override
  void initState() {
    super.initState();

      print('');
      print('ID: ${widget.id}');
      print('Writer ID: ${widget.Writer_ID}');
      print('Movie ID: ${widget.Movie_ID}');
      print('Summary: ${widget.summary}');
      print('Title: ${widget.title}');
      print('Editor ID: ${widget.Editor_ID}');
      print('Type: ${widget.Type}');

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Making Videos Clips',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Rye',color: Colors.white),),
        backgroundColor: Colors.black,
      ),


      body:


      Column(
        children: [
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Rye',color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Search Videos',
                labelStyle: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Rye',color: Colors.black),
                hintText: 'Search Videos',
                hintStyle: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Rye',color: Colors.black),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                suffixIcon: IconButton(
                  onPressed: () {
                    _fetchVideos();
                  },
                  icon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          if (_loading)

            Center(child: CircularProgressIndicator())
          else if (_errorMessage.isNotEmpty)
            Center(child: Text('Error: $_errorMessage',style: TextStyle(fontFamily: 'Rye',fontWeight: FontWeight.bold),))
          else if (_videos.isEmpty)
              Center(child: Text('No videos found',style: TextStyle(fontFamily: 'Rye',fontWeight: FontWeight.bold),))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _videos.length,
                  itemBuilder: (context, index) {
                    final video = _videos[index];
                    final title = video.title;
                    final id = video.id; // Access the id of the video
                    // Print the id of the video
                    print('Video id at index $index: $id');
                    print('ID: ${widget.id}');
                    print('Writer ID: ${widget.Writer_ID}');
                    print('Movie ID: ${widget.Movie_ID}');
                    print('Summary: ${widget.summary}');
                    print('Title: ${widget.title}');
                    print('Editor ID: ${widget.Editor_ID}');
                    print('Type: ${widget.Type}');
                   // print('Video Id: '+_videos[index].toString()+'Videothumnail: '+video.thumbnailUrl+'VideoTitle: '+video.title+'VideoDes: '+video.description);

                    final truncatedTitle = title.length > 30 ? title.substring(0, 30) : title;
                    // Adjust the length as needed
                    // Print the video object
                    print('Video at index $index: $id ');
                    return InkWell(
                      onTap: (){
                        print('Selected Video: $index: $id ');
                        // Convert video id to string explicitly
                        String videoIdAsString = id.toString();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoPlayerScreen( videoId: videoIdAsString,thumbnailUrl: video.thumbnailUrl,title: video.title,id: widget.id,Movie_ID: widget.Movie_ID,Editor_ID: widget.Editor_ID,Writer_ID: widget.Writer_ID,title1: widget.title,Type: widget.Type,summary: widget.summary,),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: Image.network(

                          video.thumbnailUrl,
                          height: 120,
                        ),
                        trailing: Text(index.toString()),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              truncatedTitle,
                              style: TextStyle(
                                fontFamily: 'BigshotOne',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Show full title
                                showDialog(

                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: Colors.blueGrey,
                                    title: Text("Full Title",style: TextStyle(fontFamily: 'BigshotOne',fontWeight: FontWeight.bold),),
                                    content: Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Rye'),),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Close',style: TextStyle(fontFamily: 'BigshotOne',fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15),),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Text(
                                '...Read More',
                                style: TextStyle(
                                  //color: Colors.blue,
                                       fontWeight: FontWeight.bold,
                                  fontFamily: 'Rye'
                                ),
                              ),
                            ),
                          ],
                        ),
                        //subtitle: Text(video.description),
                      ),
                    );
                  },
                ),
              ),

        ],
      ),
    );
  }

  Future<void> _fetchVideos() async {
    final String query = _searchController.text;
    if (query.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a search query';
      });
      return;
    }
    setState(() {
      _loading = true;
      _errorMessage = '';
      _videos.clear(); // Clear previous search results
    });
    try {
      final response = await YouTubeApi.fetchVideos(query);
      if (response.statusCode == 200) {
        final List<YouTubeVideo> fetchedVideos =
        (jsonDecode(response.body)['items'] as List<dynamic>)
            .map((item) => YouTubeVideo.fromJson(item))
            .toList();
        setState(() {
          _videos = fetchedVideos;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to fetch videos. Status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to fetch videos. Error: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

