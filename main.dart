import 'package:coffee_time/screens/wrapper.dart';
import 'package:coffee_time/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().changeAuth,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}