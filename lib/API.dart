//import 'package:http/http.dart' as http;

class APIHandler {
  static const String baseUrl1 = 'http://192.168.0.118/BlinkBackend/api';
  static const String baseUrl2 = 'http://192.168.0.118/BlinkBackend';
  static const String signUp1 = '$baseUrl1/User/Signup';

// String base_url='http://192.168.18.13/BlinkBackend/api';
  //static const String signUp = 'http://192.168.18.13/BlinkBackend/api/User/Signup';
}
// Future<int> signup(String Email,String Password,String Name,
//     String Role)async
// {
//   String url=base_url+"User/SignUp";
//   var userobj={
//     "Email":Email,
//     "Password":Password,
//     "Name":Name,
//     "Role":Role,
//
//
//   };
//   var json= jsonEncode(userobj);
//   Uri uri=Uri.parse(url);
//   var response =await  http.post(uri,body: json,
//       headers: {
//         "Content-Type":"application/json; charset=UTF8"
//       }
//   );
//   return response.statusCode;
//
// }
//
