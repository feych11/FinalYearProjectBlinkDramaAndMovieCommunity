import 'package:finalsemproject/API.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:http/http.dart'as http;
class EditorAddCommentsFroWriterScreen extends StatefulWidget {
  final String ?MovieID;
  final String ?sentProjectID;

  const EditorAddCommentsFroWriterScreen({super.key,
    this.MovieID,
    this.sentProjectID,
  });

  @override
  State<EditorAddCommentsFroWriterScreen> createState() => _EditorAddCommentsFroWriterScreenState();
}
class _EditorAddCommentsFroWriterScreenState extends State<EditorAddCommentsFroWriterScreen> {
  QuillController _controller = QuillController.basic();
  final Color Green  = Color(0xFF4FAA6D);

  @override
  void initState() {
    super.initState();
    print('MOVIEEE ID FOR API:'+widget.MovieID.toString());
    _controller = QuillController.basic();
    // int wId=int.parse(widget.Writer_ID!);
    // updateWriterNotifications(wId);
  }
  Future<void>SendComments(String SentproID,String Comments)async
  {
   try{
     const String baseurl2=APIHandler.baseUrl1;
     final responce=await http.post(Uri.parse('$baseurl2/Editor/RewriteSentProject?SentProject_ID='+SentproID+'&editorsComment='+Comments),);
     if(responce.statusCode==200)
     {
       print('Editor Add Comments Succesfully');
       showDialog(
         context: context,
         builder: (BuildContext context) {
           return AlertDialog(
             backgroundColor: Green,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(10),
             ),
             title: Text('ADD COMMENTS',style: TextStyle(fontFamily: 'BigShotone',fontSize: 20,color: Colors.white,),),
             content: Row(
               children: [
                 Icon(Icons.check, color: Colors.black,size: 30,),
                 SizedBox(width: 8),
                 Text('ADD\nCOMMENT',style: TextStyle(fontFamily: 'BigShotone',fontSize: 20,color: Colors.white,),),
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
     }
     else if(responce.statusCode==404)
     {
       print('Failed To Add Editor Comments');
     }
     else
     {
       print('Something Went Wrong ${responce.reasonPhrase}');
     }

   }
   catch(error)
   {
     print('Error To Add Editor Comments${error} ');
   }
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Write Summary', style: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white,fontFamily: 'BigshotOne'),),
        backgroundColor: Colors.black,),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(children: [
            SizedBox(height: 20,),
            Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(
                child: Text('ADD COMMENTS', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white,
                    fontFamily: 'BigshotOne'),),
              ),
            ),
            SizedBox(height: 20,),
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
                      readOnly: false,
                      sharedConfigurations: const QuillSharedConfigurations(
                        locale: Locale('de'),
                      ),
                    ),
                  ),
                ),
              ],),
            ),
            SizedBox(height: 20,),
            Center(
              child: ElevatedButton(onPressed: () {
              SendComments(widget.sentProjectID!, _controller.document.toPlainText());
              },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.black), // Change button color
                  minimumSize: MaterialStateProperty.all<Size>(
                      Size(10, 50)), // Adjust button size
                  // You can also customize other aspects of the button's appearance here
                ),
                child: Center(child: Text('Save', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white,
                    fontFamily: 'BigshotOne'),)
                ),
              ),
            ),
            SizedBox(height: 20,)


          ],),
        ),
      ),

    );
  }
}
