import 'package:coffee_time/models/user.dart';
import 'package:coffee_time/screens/authenticate/authenticate.dart';
import 'package:coffee_time/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //Show login page or home page based on value received from Stream
    if(user == null)
      return Authenticate();
    else
      return Home();  
  }
}