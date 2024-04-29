import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'dart:convert';
class WriterRewriteSummaryScreen extends StatefulWidget {
  String?Summary;
  String?Title;
  WriterRewriteSummaryScreen({super.key,
  this.Summary,
  this.Title
  });

  @override
  State<WriterRewriteSummaryScreen> createState() => _WriterRewriteSummaryScreenState();
}

class _WriterRewriteSummaryScreenState extends State<WriterRewriteSummaryScreen> {
  QuillController _controller = QuillController.basic();

  @override
  void initState() {
    super.initState();
    print('Summary: ${widget.Summary}');
    _controller = QuillController.basic();
    if (widget.Summary != null) {
      _controller.document.insert(0, widget.Summary!);
    }
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Text('  Movie: ${widget.Title}', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white,
                  fontFamily: 'BigshotOne'),),
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
            Row(

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                ElevatedButton(onPressed: () {



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
                ElevatedButton(onPressed: () {

                },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.black), // Change button color
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(10, 50)), // Adjust button size
                    // You can also customize other aspects of the button's appearance here
                  ),
                  child: Center(child: Text('Make Clips', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white,
                      fontFamily: 'BigshotOne'),)
                  ),
                ),

              ],),
            SizedBox(height: 20,)


          ],),
        ),
      ),

    );
  }
}
