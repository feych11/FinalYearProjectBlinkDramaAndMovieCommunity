class VideoClip {
  double start_time; // Lowercase the first letter for consistency
  double end_time; // Lowercase the first letter for consistency
  String? url; // Lowercase the first letter for consistency
  bool isCompoundClip = false;
  bool SimpleClip=false;
  String thumbnailUrl;
  String title;
 // final String thumbnailUrl;

  VideoClip({
    required this.start_time, // Define named parameter start_time
    required this.end_time, // Define named parameter end_time
    required this.url, // Define named parameter url
    this.isCompoundClip = false,
    this.SimpleClip=false,
    required this.thumbnailUrl,
    required this.title,
  });
}
