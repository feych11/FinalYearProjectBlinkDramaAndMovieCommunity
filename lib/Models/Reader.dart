import 'dart:io';

class Reader
{
  late int RID;
  late String Name;
  late String Password;
  late File image;
  late String Subscription;
  late int Balance;
  late String Interest;
  Reader({required this.RID,required this.Name,required this.Password,required this.image,required this.Subscription,
    required this.Balance,required this.Interest
  });
  Map<String,dynamic> toMap()
  {
    return {
      "RID":RID,
      "Name":Name,
      "Password":Password,
      "Subscription":Subscription,
      "Balance":Balance,
      "Interest":Interest
    };
  }


}