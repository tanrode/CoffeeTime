import 'package:coffee_time/models/user.dart';
import 'package:coffee_time/services/database.dart';
import 'package:coffee_time/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
 
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3'];
  
  //form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;
 
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {

        if(snapshot.hasData)
        {
          UserData ud = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(color: Colors.brown[300], width: MediaQuery.of(context).size.width,height: 35 , child: Center(child: Text('Change Coffee Settings',style: TextStyle(fontSize: 18.0,color: Colors.white,fontWeight: FontWeight.bold),))),
                
                TextFormField(validator: (val)=>
                      val.isEmpty ? 'Enter Name' : null,
                      initialValue: ud.name,
                      decoration: InputDecoration(labelText:'Name'),
                      onChanged: (val) {
                    setState(() {
                      _currentName=val;
                    });
                  },),
                
                  SizedBox(
                    height: 8.0,
                  ),
                  
                  DropdownButtonFormField(
                    value: _currentSugars ?? ud.sugar,
                    items: sugars.map((s){
                        return DropdownMenuItem(
                          value: s,
                          child: Text('$s sugar cubes'));
                    }).toList(),onChanged: (val){
                      setState(() {
                        _currentSugars=val;  
                      });
                    },
                  ),   
                  
                  SizedBox(
                    height: 8.0,
                  ),

                  Slider(
                    label: 'Strength:'+_currentStrength.toString(),
                    min: 100,
                    max:900,
                    divisions: 8,
                    activeColor: Colors.brown[_currentStrength ?? ud.strength],
                    inactiveColor: Colors.brown[_currentStrength ?? ud.strength],
                    value: (_currentStrength ?? ud.strength).toDouble(),
                    onChanged: (val){
                      setState(() {
                        _currentStrength=val.round();
                      });
                    }),
                  
                  SizedBox(
                    height: 8.0,
                  ),
                
                  RaisedButton(child: Text('Apply'),color: Colors.pink[200], onPressed: () async{
                      if(_formKey.currentState.validate()){
                        await DatabaseService(uid: user.uid).updateUserdata(
                          _currentSugars ?? ud.sugar,
                          _currentName ?? ud.name,
                          _currentStrength ?? ud.strength);
                        Navigator.pop(context);  
                      }
                  }),
              ],
            ));
        }
        else
        {
          return Loading();
        }
        

        
      }
    );
  }
}