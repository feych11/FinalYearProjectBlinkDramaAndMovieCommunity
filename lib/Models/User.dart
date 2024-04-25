class User
{
  late int userid;
  late String Name,Email,Password;
  User.fromMap(Map<String,dynamic> map)
  {
    userid=map["userId"];
    Name=map["Name"];
    Email=map["id"];
    Password=map["title"];
  }

}