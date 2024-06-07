import 'package:finalsemproject/API.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:http/http.dart'as http;

class WriterRewriteSummaryScreen extends StatefulWidget {
  String?Summary;
  String?Title;
  int?SentprojectID;
  WriterRewriteSummaryScreen({super.key,
  this.Summary,
  this.Title,
    this.SentprojectID
  });

  @override
  State<WriterRewriteSummaryScreen> createState() => _WriterRewriteSummaryScreenState();
}

class _WriterRewriteSummaryScreenState extends State<WriterRewriteSummaryScreen> {
  QuillController _controller = QuillController.basic();
  Future<void> SendUpdateSummry(String sentId, String updatedSummary) async {
    const String baseUrl = APIHandler.baseUrl1;
    const String updateSummaryUrl = '$baseUrl/Writer/UpdateRewriteSummary';

    try {
      final response = await http.post(
        Uri.parse('$updateSummaryUrl?SentProject_ID=$sentId&updatedSummary=$updatedSummary'),
      );

      if (response.statusCode == 200) {
        print('Summary updated successfully');
      } else {
        throw Exception('Failed to update summary');
      }
    } catch (error) {
      print('Failed to update summary: $error');
    }
  }


  @override
  void initState() {
    super.initState();
    print('Summary: ${widget.Summary}');
    print('SEntProject ID::: ${widget.SentprojectID}');

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
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Text('  Movie: ${widget.Title}', style: const TextStyle(
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
            ElevatedButton(onPressed: () {
              print('Sumary updated:${_controller.document.toPlainText()}');
              // Assuming widget.SentprojectID is of type int?
               // Use 0 as default value if it's null

              SendUpdateSummry(widget.SentprojectID.toString(), _controller.document.toPlainText());

            },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.black), // Change button color
                minimumSize: MaterialStateProperty.all<Size>(
                    const Size(10, 50)), // Adjust button size
                // You can also customize other aspects of the button's appearance here
              ),
              child: const Center(child: Text('RESEND', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white,
                  fontFamily: 'BigshotOne'),)
              ),
            ),
            const SizedBox(height: 20,)


          ],),
        ),
      ),

    );
  }
}
