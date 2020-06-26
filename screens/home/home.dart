import 'package:coffee_time/models/brew.dart';
import 'package:coffee_time/screens/home/settings_form.dart';
import 'package:coffee_time/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_time/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'brewList.dart';

class Home extends StatelessWidget {

  final AuthService _auth=AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel()
    {
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
          value: DatabaseService().beverages ,
          child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(title:Text('CoffeeTime',style: TextStyle(fontSize:21),),centerTitle: true,backgroundColor: Colors.brown[400],actions: <Widget>[
          FlatButton.icon(icon: Icon(Icons.person),label:Text('Logout'),onPressed: () async{
            return await _auth.signOut();
          }),
          FlatButton.icon(icon: Icon(Icons.settings), label: Text('Settings'),onPressed: ()=>_showSettingsPanel()),
        ],),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/assets/coffeeBG.jpg'),
                fit: BoxFit.cover,
            ),
          ),
          child: BrewList()),
      ),
    );
  }
}