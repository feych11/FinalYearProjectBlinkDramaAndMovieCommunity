import 'package:http/http.dart' as http;

class YouTubeApi {
  static const String baseURL = 'https://www.googleapis.com/youtube/v3/';
  static const String apiKey = 'AIzaSyB1RTKCZp3eHMC67Hnal-JezMVxTjUdoPI'; // Your YouTube Data API Key

  static Future<http.Response> fetchVideos(String query) async {
    final response = await http.get(
      Uri.parse('https://www.googleapis.com/youtube/v3/search?part=snippet&q=$query&key=AIzaSyB1RTKCZp3eHMC67Hnal-JezMVxTjUdoPI '),
        // https://www.googleapis.com/youtube/v3/search?part=snippet&q=Flutter%20tutorial&key=AIzaSyB1RTKCZp3eHMC67Hnal-JezMVxTjUdoPI
    );

    return response;
  }
}
