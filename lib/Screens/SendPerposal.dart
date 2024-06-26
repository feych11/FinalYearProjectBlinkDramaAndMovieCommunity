import 'dart:convert';

import 'package:finalsemproject/API.dart';
import 'package:finalsemproject/Screens/CustomeSendPerposal.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
class SendPerposal extends StatefulWidget {
  const SendPerposal({super.key});

  @override
  State<SendPerposal> createState() => _SendPerposalState();
}

class _SendPerposalState extends State<SendPerposal> {
  final TextEditingController _moviesconController =TextEditingController();
  TextEditingController Dircon =TextEditingController();
  TextEditingController Deadcon =TextEditingController();
  TextEditingController Catcon=TextEditingController();
  TextEditingController CharCon=TextEditingController();
  TextEditingController EpiCon=TextEditingController();
  TextEditingController CastCon=TextEditingController();

  File? _image;
  final Color Green  = const Color(0xFF4FAA6D);
  List<dynamic> _writers = [];
  String? _selectedWriter;
  List<dynamic> _movies = [];
  int?count;
  List<dynamic>_dramas=[];
  String? _selectedmovie;
  String? userId;
  List<dynamic>Exwritername=[];
  bool IsSelected = false;
  String imagePath = '';
  bool _chargesEnabled = false;
  bool _episodeEnabled = false;
  final picker = ImagePicker();
  String _selectedType = 'Select type';
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark().copyWith(
              primary: Colors.white, // Change the color to your desired color
            ),
          ),
          child: child!,
        );
      },

    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        Deadcon.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }
  //List<String> _selectedCategories = [];
  List<String> _selectedCategories1 = [];
  final List<String> _categories = [
    'Action',
    'Comedy',
    'Romantic',
    'Horror',
    'Sci-Fi',
    'Adventure',
    'Drama',
  ];

  // void _toggleCategory(String category) {
  //   setState(() {
  //     if (_selectedCategories.contains(category)) {
  //       _selectedCategories.remove(category);
  //     } else {
  //       _selectedCategories.add(category);
  //     }
  //   });
  // }

  // Future<void> fetchWriters() async {
  //   try {
  //     const String baseurl2=APIHandler.baseUrl1;
  //     final response = await http.get(Uri.parse('$baseurl2/Writer/getAllWrite'));
  //
  //     if (response.statusCode == 200) {
  //       final responseData = json.decode(response.body);
  //       setState(() {
  //         _writers = responseData;
  //       });
  //     } else {
  //       throw Exception('Failed to load writers');
  //     }
  //   } catch (error) {
  //     print(error);
  //   }
  // }


  // Future<void> updateAllEditorNotificationsToFalseSentProject(int editorId) async {
  //   try {
  //     const String baseUrl = 'http://192.168.43.218/BlinkBackend/api'; // Replace with your API base URL
  //     final response = await http.post(
  //       Uri.parse('$baseUrl/Editor/UpdateAllEditorNotificationstoFalseSentProject/$editorId'),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       print('All Editor notifications updated to false for the specified editor');
  //     } else if (response.statusCode == 404) {
  //       print('No SentProject records found for the specified editor');
  //     } else {
  //       print('Failed to update Editor notifications: ${response.reasonPhrase}');
  //     }
  //   } catch (error) {
  //     print('Error updating Editor notifications: $error');
  //   }
  // }
  // Future<void> updateAllEditorNotificationsToFalse(int editorId) async {
  //   try {
  //     const String baseurl2=APIHandler.baseUrl1; // Replace with your API base URL
  //     final response = await http.post(
  //       Uri.parse('$baseurl2/Editor/updateAllEditorNotificationsToFalse/$editorId'),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       print('All editor notifications updated successfully');
  //     } else if (response.statusCode == 404) {
  //       print('No SentProposals found for the specified editor');
  //     } else {
  //       print('Failed to update all editor notifications: ${response.reasonPhrase}');
  //     }
  //   } catch (error) {
  //     print('Error updating all editor notifications: $error');
  //   }
  // }
  //
  // Future<void> updateEditorNotifications(int editorId) async {
  //   try {
  //     const String baseurl2=APIHandler.baseUrl1; // Replace with your API base URL
  //     final response = await http.post(
  //       Uri.parse('$baseurl2/Editor/updateEditorNotifications/$editorId'),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       print('Editor notifications updated successfully');
  //     } else if (response.statusCode == 404) {
  //       print('No SentProposals found for the specified editor');
  //     } else {
  //       print('Failed to update editor notifications: ${response.reasonPhrase}');
  //     }
  //   } catch (error) {
  //     print('Error updating editor notifications: $error');
  //   }
  // }
  Future<void> fetchWriters(String genre) async {
    const String baseurl2=APIHandler.baseUrl1;
    print(genre);
    final url = Uri.parse('$baseurl2/Writer/GetWriterAccordingToGenre?movieGenre=$genre');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          if(responseData != null){
            _writers = responseData;
            print(_writers);
          }
        });
      } else {
        throw Exception('Failed to load writers');
      }
    } catch (error) {
      print('Error fetching writers: $error');
    }
  }

  Future<void> fetchMovies() async {
    try {
      const String baseurl2=APIHandler.baseUrl1;
      final response = await http.get(Uri.parse('$baseurl2/Editor/GetAllMoviesName'));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          _movies = responseData;
          // print(responseData);
        });
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (error) {
      print(error);
    }
  }
  Future<void> fetchDrama() async {
    try {
      const String baseurl2=APIHandler.baseUrl1;
      final response = await http.get(Uri.parse('$baseurl2/Editor/GetAllDramasName'));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          _dramas = responseData;
          // print(responseData);
        });
      } else {
        throw Exception('Failed to load Dramas');
      }
    } catch (error) {
      print(error);
    }
  }
  Future<void> fetchMovieDetails(String movieid) async {
    try {
      const String baseUrl2 = APIHandler.baseUrl1;
      const String baseurl3=APIHandler.baseUrl2;
      final response = await http.get(Uri.parse('$baseUrl2/Reader/GetSpecificMovie?Movie_ID=$movieid'));
      print('Movie id$movieid');
      print('IDJSJSSN:$userId');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        // Update text fields with fetched data
        setState(() {
          Dircon.text = responseData['movies']['Director'];

          Exwritername = responseData['Writers'];
          for (var writer in Exwritername) {
            print('Writerrrr: ${writer['Writer_ID']}');
          }
          count=responseData['count'];
          print('Count or length: ${count}');

          //Deadcon.text = responseData['DueDate'];
          //_selectedCategories = responseData['Category'].split(',');
          _selectedCategories1=responseData['movies']['Category'].split(',');
          _selectedType = responseData['movies']['Type'];
          print(_selectedCategories1.join(','));
          print(_selectedType);
          // print('Selectedcategories: '+_selectedCategories.join(','),);
          imagePath =responseData['movies']['Image'];
          imagePath= 'http://192.168.0.104/BlinkBackend/Images/${responseData['movies']['Image']}';
          IsSelected= true;

          if(responseData['movies']['Type'] == "Movie"){
            _chargesEnabled = true;
          }
          else if(responseData['movies']['Type'] == "Drama"){
            _chargesEnabled = true;
            _episodeEnabled = true;
          }
          //_image = imagePath;
          print(responseData['movies']['Image']);// Assuming you receive image URL
          fetchWriters(_selectedCategories1.join(','));
        });
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (error) {
      print(error);
    }
  }

  void showWritersDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return
          Theme(
            data: ThemeData( // Define custom theme data
            dialogBackgroundColor: Colors.grey, // Background color
            dialogTheme: DialogTheme( // Define dialog theme
            shape: RoundedRectangleBorder( // Define border shape
            side: const BorderSide(color: Colors.black,width: 4), // Border color
        borderRadius: BorderRadius.circular(20.0), // Border radius
        ),
        ),
        ),
        child:
          AlertDialog(
          title: Text('Ex Writers',style: TextStyle(fontSize: 25,fontFamily: 'BigshotOne'),),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: Exwritername.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(Exwritername[index]['WriterUserName'],style: TextStyle(fontSize: 23,fontFamily: 'BigshotOne')),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text('Close',style: TextStyle(fontFamily: 'BigshotOne',fontSize: 20,color: Colors.black),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
      },
    );
  }


  Future<void> sendProposal() async {
    const String baseUrl = APIHandler.baseUrl1;

    try {
      List<int> imageBytes = await _image!.readAsBytes();
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/Editor/SentProposal'));

      request.headers['Content-Type'] = 'multipart/form-data';

      request.fields.addAll({
        'Movie_ID': _selectedmovie!,
        'Director': Dircon.text,
        'DueDate': Deadcon.text,
        'Genre': _selectedCategories1.join(','), // Assuming genre is a comma-separated string
        'Type': _selectedType,
        'Writer_ID': _selectedWriter!,
        'Editor_ID': userId.toString(),
        'Movie_Name': _moviesconController.text,
        'Episode': EpiCon.text.isEmpty ? '0' : EpiCon.text, // Handle empty episode input
        'Amount': CharCon.text,
        'Cast':CastCon.text,
      });

      File? image = _image;
      if (image != null) {
        String imagePath = image.path;
        request.files.add(
          await http.MultipartFile.fromPath('Image', imagePath),
        );
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        print('Sent Proposal Successful');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: const Text('Send Proposal',style: TextStyle(fontFamily: 'BigShotone',fontSize: 20,color: Colors.white,),),
              content: const Row(
                children: [
                  Icon(Icons.check, color: Colors.black,size: 30,),
                  SizedBox(width: 8),
                  Text('SENT\nSUCCESSFULLY',style: TextStyle(fontFamily: 'BigShotone',fontSize: 20,color: Colors.white,),),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  },
                  child: const Text('OK',style: TextStyle(fontFamily: 'BigShotone',fontSize: 20,color: Colors.white,),),
                ),
              ],
            );
          },
        );
        print(responseData);
      } else {
        var responseData = await response.stream.bytesToString();
        print('Failed to send proposal. Error: ${response.reasonPhrase}');
        print('Response Data: $responseData');
      }
    } catch (e) {
      print('Error sending proposal: $e');
    }
  }



  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
  Future<void> getEditorId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('Editor_ID');
    setState(() {
      userId = user;
      print('EditorIDDDDDD: $userId');
    });
  }


  @override
  void initState() {
    super.initState();
    getEditorId();

    //fetchWriters();
    //fetchWriters(_selectedCategories1.join(','));
    fetchMovies();
    //updateEditorNotifications(2);
    //updateAllEditorNotificationsToFalse(2);
  }
  @override
  void dispose() {
    _moviesconController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,

      appBar: AppBar(title:Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text('SEND PROPOSAL',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'BigshotOne'),
          ),
          InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const CustomeSendPerposal()));
              },
              child: const Icon(Icons.add,color: Colors.white,))
        ],),

        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Stack(children: [


        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Images/LoginPagePhoto.png'), // Your background image
              fit: BoxFit.cover,
            ),
          ),
        ),

        SingleChildScrollView(
          child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
            child: Column(

              children: [
                Container(
                  width: 470,
                  height: 952,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black,
                      width: 9,
                    ),
                  ),

                  child: Column(children: [


                    SafeArea(
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('Movie And Drama:',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,fontFamily: 'Rye'),),
                          const SizedBox(width: 10),
                          DropdownButton<String>(
                            value: _selectedmovie,style: const TextStyle(fontFamily: 'BigshotOne'),
                            dropdownColor: Colors.white,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedmovie = newValue;
                                // Update the text field value when a movie is selected
                                _moviesconController.text = _selectedmovie != null ? _movies.firstWhere((movie) => movie['Id'].toString() == _selectedmovie)['Name'] : '';
                                fetchMovieDetails(newValue!);

                                // fetchWriters(_selectedCategories1.join(','));
                                print('Sel Cat${_selectedCategories1.join(',')}');
                              });
                            },
                            iconSize: 30,
                            items: _movies.map<DropdownMenuItem<String>>((movie) {
                              return DropdownMenuItem<String>(
                                value: movie['Id'].toString(),

                                child: Text(movie['Name'],style: const TextStyle(fontSize: 20,color: Colors.black),),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _moviesconController,style: const TextStyle(fontFamily: 'BigshotOne',color: Colors.black),
                      decoration: InputDecoration(
                        labelText: '     Movie Name',
                        labelStyle: const TextStyle(fontFamily: 'BigshotOne',color: Colors.black),
                        hintText: 'Movie Name',
                        hintStyle: const TextStyle(fontFamily: 'BigshotOne',color: Colors.black),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    TextFormField(
                      controller: Dircon,style: const TextStyle(fontFamily: 'BigshotOne',color: Colors.black),
                      decoration: InputDecoration(
                        prefix: const Icon(Icons.person),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.black)),
                        labelText: 'Director Name',
                        labelStyle: const TextStyle(fontFamily: 'BigshotOne',color: Colors.black),
                        hintText: 'Director Name',
                        hintStyle: const TextStyle(fontFamily: 'BigshotOne',color: Colors.black),



                      ),
                    ),
                    const SizedBox(height: 30,),
                    TextFormField(
                      controller: CastCon,style: const TextStyle(fontFamily: 'BigshotOne',color: Colors.black),
                      decoration: InputDecoration(
                        prefix: const Icon(Icons.person),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.black)),
                        labelText: 'Enter Your Movie or Drama Cast',
                        labelStyle: const TextStyle(fontFamily: 'BigshotOne',color: Colors.black),
                        hintText: 'Enter Your Movie or Drama Cast',
                        hintStyle: const TextStyle(fontFamily: 'BigshotOne',color: Colors.black),



                      ),
                    ),
                    const SizedBox(height: 30,),
                    TextFormField(
                      controller: Deadcon,style: const TextStyle(fontFamily: 'BigshotOne',color: Colors.black),
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: '     Select Date',
                        labelStyle: const TextStyle(fontFamily: 'BigshotOne',color: Colors.black),
                        hintText: 'Select Date',
                        hintStyle: const TextStyle(fontFamily: 'BigshotOne',color: Colors.black),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        prefix: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () {
                            _selectDate(context);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Type',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Rye'),),
                        const SizedBox(width: 10),
                        DropdownButton<String>(
                          value: _selectedType,style: const TextStyle(fontFamily: 'BigshotOne'),
                          dropdownColor: Colors.white,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedType = newValue!;
                              if (_selectedType == 'Movie') {
                                print((_selectedType));
                                _chargesEnabled = true;
                              } else if (_selectedType == 'Drama') {
                                _chargesEnabled = true;
                                _episodeEnabled = true;
                              }
                            });
                          },
                          iconSize: 30,
                          items: <String?>['Select type', 'Movie', 'Drama']
                              .map<DropdownMenuItem<String>>((String? value) {
                            return DropdownMenuItem<String>(
                              value: value,

                              child: Center(child: Text(value!,style: const TextStyle(fontSize: 20,color: Colors.black),)),
                            );
                          }).toList(),
                        ),


                      ],
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: CharCon,style: const TextStyle(fontFamily: 'BigshotOne',color: Colors.black),
                      enabled: _chargesEnabled,
                      decoration: InputDecoration
                        (
                        hintText: 'Charges',
                        hintStyle: const TextStyle(fontFamily: 'BigshotOne',color: Colors.black),
                        labelText: 'Charges',
                        labelStyle: const TextStyle(fontFamily: 'BigshotOne',color: Colors.black),
                        prefixIcon: const Icon(Icons.money),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: EpiCon,style: const TextStyle(fontFamily: 'BigshotOne',color: Colors.black),
                      enabled: _episodeEnabled,
                      decoration: InputDecoration
                        (
                        hintText: 'Episode No: ',
                        hintStyle: const TextStyle(fontFamily: 'BigshotOne',color: Colors.black),
                        labelText: 'Episode No: ',
                        labelStyle: const TextStyle(fontFamily: 'BigshotOne',color: Colors.black),
                        prefixIcon: const Icon(Icons.movie),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),

                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black, // Background color
                      ),
                      onPressed: () {
                        showWritersDialog(context);
                      },
                      child: Text(
                        'Ex Writer',
                        style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'BigshotOne'), // Text color
                      ),
                    ),


                    const SizedBox(height: 30),
                    TextFormField(
                      controller: TextEditingController(
                        text: _selectedCategories1.isNotEmpty
                            ? _selectedCategories1.join(', ')
                            : null,
                      ),style: const TextStyle(fontFamily: 'BigshotOne',color: Colors.black),
                      decoration: const InputDecoration(
                        hintText: 'Categories',
                        hintStyle: TextStyle(fontFamily: 'BigshotOne',color: Colors.black),
                        labelText: 'Categories',
                        labelStyle: TextStyle(fontFamily: 'BigshotOne',color: Colors.black),
                        prefixIcon: Icon(Icons.category),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),

                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Writer',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontFamily: 'Rye'),),
                        const SizedBox(width: 10),
                        DropdownButton<String>(
                          value: _selectedWriter,
                          dropdownColor: Colors.white,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedWriter = newValue;
                            });
                          },
                          iconSize: 30,
                          items: _writers.isEmpty
                              ? [const DropdownMenuItem<String>(
                            value: null,
                            child: Center(child: Text('No writers present',style: TextStyle(fontFamily: 'BigshotOne',color: Colors.black),)),
                          )]
                              :[
                            const DropdownMenuItem<String>(
                              value: null,
                              child: Center(child: Text('Select writer')),
                            ),
                            ..._writers.map<DropdownMenuItem<String>>((writer) {
                              return DropdownMenuItem<String>(
                                value: writer['WriterID'].toString(),
                                child: Center(
                                  child: Text(
                                    writer['UserName'],style: const TextStyle(fontFamily: 'BigshotOne',color: Colors.black,fontSize: 20),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ],),),
                const SizedBox(height: 10,),
                // TextFormField(
                //   decoration: InputDecoration(
                //     labelText: 'Categories',
                //     prefixIcon: IconButton(
                //       icon: Icon(Icons.category),
                //       onPressed: () {
                //         _showCategoryDialog(context);
                //       },
                //     ),
                //   ),
                //   controller: TextEditingController(
                //     text: _selectedCategories.isNotEmpty
                //         ? _selectedCategories.join(', ')
                //         : null,
                //   ),
                //   readOnly: true,
                // ),
                const SizedBox(height:10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],

                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[200],
                        ),
                        height: 200,
                        width: 200,
                      ),
                      _image == null
                          ? const Text(
                        'No image selected.',style: TextStyle(fontFamily: 'BigshotOne',color: Colors.black,fontSize: 20),
                      )
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          _image!,
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),

                ),
                const SizedBox(height: 20,),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your onPressed logic here
                      sendProposal();
                      print('Elevated Button Pressed');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Background color
                      foregroundColor: Colors.white, // Text color
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Button padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Button border radius
                      ),
                      elevation: 3, // Button shadow
                    ),
                    child: const Text(
                      'SEND PROPOSAL',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'BigshotOne'
                      ),
                    ),
                  ),
                ),



              ],),
          ),

        ),
      ],),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: const Icon(Icons.add_a_photo),
      ),

    );


  }
//   void _showCategoryDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Select Categories'),
//           content: Container(
//             width: double.maxFinite,
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: _categories.length,
//               itemBuilder: (BuildContext context, int index) {
//                 final category = _categories[index];
//                 return CheckboxListTile(
//                   title: Text(category),
//                   value: _selectedCategories.contains(category),
//                   onChanged: (bool? value) {
//                     _toggleCategory(category);
//                   },
//                 );
//               },
//             ),
//           ),
//
//
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
}
