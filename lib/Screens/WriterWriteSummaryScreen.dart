import 'dart:convert';
import 'package:finalsemproject/Screens/VideoClip.dart';
import 'package:finalsemproject/Screens/WriterMakingClipsScreen.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finalsemproject/API.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
class WriterAcceptedProjectScreen extends StatefulWidget {
  final int? id;
  final int ?Movie_ID;
  final int ?Editor_ID;
  final String ?Writer_ID;
  final String ?title;
  final String ?writerName;
  final String ?Type;
  final String ?status;
  final String ?imagePath;
  final int?Episode;
  final List<VideoClip> ? videoClips;
  const WriterAcceptedProjectScreen({super.key,
    this.id,
    this.Movie_ID,
    this.Editor_ID,
    this.Writer_ID,
    this.title,
    this.writerName,
    this.Type,
    this.status,
    this.imagePath,
    this.Episode,
    this.videoClips});

  @override
  State<WriterAcceptedProjectScreen> createState() => _WriterAcceptedProjectScreenState();
}

class _WriterAcceptedProjectScreenState extends State<WriterAcceptedProjectScreen> {
  QuillController _controller = QuillController.basic();


  @override
  void initState() {
    super.initState();
    _controller = QuillController.basic();
    print('');
    print('ID: ${widget.id}');
    print('Writer ID: ${widget.Writer_ID}');
    print('Movie ID: ${widget.Movie_ID}');
    // print('Summary: ${widget.summary}');
    print('Title: ${widget.title}');
    print('Editor ID: ${widget.Editor_ID}');
    print('Type: ${widget.Type}');
    print('Episode: ${widget.Episode}');
    // int wId=int.parse(widget.Writer_ID!);
    // updateWriterNotifications(wId);
  }
  Future<void> setSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('Episode', widget.Episode ?? 0);
    await prefs.setInt('id', widget.id ?? 0);
    await prefs.setString('Writer_ID', widget.Writer_ID ?? '');
    await prefs.setInt('Movie_ID', widget.Movie_ID ?? 0);
    await prefs.setString('summary', _controller.document.toPlainText());
    await prefs.setString('title', widget.title ?? '');
    await prefs.setInt('Editor_ID', widget.Editor_ID ?? 0);
    await prefs.setString('Type', widget.Type ?? '');
  }

  Future<void> printSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? episode = prefs.getInt('Episode');
    int? id = prefs.getInt('id');
    String? writerID = prefs.getString('Writer_ID');
    int? movieID = prefs.getInt('Movie_ID');
    String? summary = prefs.getString('summary');
    String? title = prefs.getString('title');
    int? editorID = prefs.getInt('Editor_ID');
    String? type = prefs.getString('Type');

    print('Episodeeee: $episode');
    print('IDeee: $id');
    print('Writer_IDeee: $writerID');
    print('Movie_IDeee: $movieID');
    print('Summary: $summary');
    print('Title: $title');
    print('Editor_ID: $editorID');
    print('Type: $type');
  }


  // Future<void> updateWriterNotifications(int writerId) async {
  //   try {
  //     const String baseurl2 = APIHandler.baseUrl1; // Replace with your API base URL
  //     final response = await http.post(
  //       Uri.parse('$baseurl2/Writer/UpdateWriterNotifications/$writerId'),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       print('Writer notifications updated successfully');
  //     } else if (response.statusCode == 404) {
  //       print('No SentProposals found for the specified writer');
  //     } else {
  //       print('Failed to update Writer notifications: ${response.reasonPhrase}');
  //     }
  //   } catch (error) {
  //     print('Error updating Writer notifications: $error');
  //   }
  // }


  Future<void> sendProject(var data) async {
    const String baseurl2 = APIHandler.baseUrl1;
    const String baseurl3 = APIHandler.baseUrl2;
    var url = Uri.parse('$baseurl2/Writer/SentProject');
    print(data);
    try {
      var response = await http.post(
        url,
        body: json.encode(data),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Project sent successfully
        print('Project sent');
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


    // @override
    // Widget build(BuildContext context) {
    //   return Scaffold(
    //     appBar: AppBar(
    //       centerTitle: true,
    //       title: Text('Write Summary', style: TextStyle(
    //           fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),),
    //       backgroundColor: Colors.black,),
    //     body: SingleChildScrollView(
    //       scrollDirection: Axis.vertical,
    //       child: Column(children: [
    //         Card(
    //           elevation: 5,
    //           color: Colors.black,
    //           child: Text('Movie: ${widget.title}', style: TextStyle(
    //             fontWeight: FontWeight.bold,
    //             fontSize: 30,
    //             color: Colors.white,),),
    //         ),
    //         Container(
    //
    //           child: Column(children: [
    //             Container(
    //               color: Colors.grey,
    //               child: QuillToolbar.simple(
    //                 configurations: QuillSimpleToolbarConfigurations(
    //                   controller: _controller,
    //                   sharedConfigurations: const QuillSharedConfigurations(
    //                     locale: Locale('de'),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             Container(
    //               alignment: Alignment.topRight,
    //
    //               height: 300,
    //               width: 350,
    //               decoration: BoxDecoration(
    //                   color: Colors.white,
    //                   borderRadius: BorderRadius.circular(20)
    //               ),
    //               child: QuillEditor.basic(
    //                 configurations: QuillEditorConfigurations(
    //                   controller: _controller,
    //                   readOnly: false,
    //                   sharedConfigurations: const QuillSharedConfigurations(
    //                     locale: Locale('de'),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],),
    //         ),
    //         SizedBox(height: 20,),
    //         Center(child: ElevatedButton(onPressed: () {
    //           var data = {
    //             'SentProposal_ID': widget.id,
    //             'Writer_ID': widget.Writer_ID,
    //             'Movie_ID': widget.Movie_ID,
    //             'Summary': _controller,
    //             'Editor_ID': widget.Editor_ID,
    //           };
    //
    //           sendProject(data);
    //         },
    //             style: ButtonStyle(
    //               backgroundColor: MaterialStateProperty.all<Color>(
    //                   Colors.black), // Change button color
    //               minimumSize: MaterialStateProperty.all<Size>(
    //                   Size(10, 50)), // Adjust button size
    //               // You can also customize other aspects of the button's appearance here
    //             ),
    //             child: Center(child: Text('Save', style: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 30,
    //                 color: Colors.white),))))
    //
    //       ],),
    //     ),
    //
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Write Summary', style: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white,fontFamily: 'BigshotOne'),),
        backgroundColor: Colors.black,),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(children: [
            const SizedBox(height: 20,),
            Container(
              height: 50,
              width: 170,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Text('  Movie: ${widget.title}', style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white,
                  fontFamily: 'BigshotOne'),),
            ),
            const SizedBox(height: 20,),
            Container(

              child: Column(children: [
                Container(
                  color: Colors.grey,
                  child: QuillToolbar.simple(
                    configurations: QuillSimpleToolbarConfigurations(
                      controller: _controller,
                      sharedConfigurations: const QuillSharedConfigurations(
                        locale: Locale('de'),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,

                  height: 300,
                  width: 350,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: QuillEditor.basic(
                    configurations: QuillEditorConfigurations(
                      controller: _controller,
                      //readOnly: false,
                      sharedConfigurations: const QuillSharedConfigurations(
                        locale: Locale('de'),
                      ),
                    ),
                  ),
                ),
              ],),
            ),
            const SizedBox(height: 20,),
            Row(

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                ElevatedButton(onPressed: () {
                  var data = {
                    'SentProposal_ID': widget.id,
                    'Writer_ID': widget.Writer_ID,
                    'Movie_ID': widget.Movie_ID,
                    'Summary': _controller.document.toPlainText(),
                    'Editor_ID': widget.Editor_ID,
                  };

                  sendProject(data);
                },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.black), // Change button color
                    minimumSize: MaterialStateProperty.all<Size>(
                        const Size(10, 50)), // Adjust button size
                    // You can also customize other aspects of the button's appearance here
                  ),
                  child: const Center(child: Text('Save', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white,
                      fontFamily: 'BigshotOne'),)
                  ),
                ),
                ElevatedButton(onPressed: ()async {
                  await setSharedPreferences();
                  printSharedPreferences();

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>WriterMakingClipsScreen(Episode: widget.Episode,id: widget.id,Writer_ID: widget.Writer_ID,Movie_ID: widget.Movie_ID,summary: _controller.document.toPlainText(),title: widget.title,Editor_ID: widget.Editor_ID,Type: widget.Type,)));
                },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.black), // Change button color
                    minimumSize: MaterialStateProperty.all<Size>(
                        const Size(10, 50)), // Adjust button size
                    // You can also customize other aspects of the button's appearance here
                  ),
                  child: const Center(child: Text('Make Clips', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white,
                      fontFamily: 'BigshotOne'),)
                  ),
                ),

              ],),
            const SizedBox(height: 20,)


          ],),
        ),
      ),

    );
  }
}
