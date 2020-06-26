import 'package:coffee_time/services/auth.dart';
import 'package:coffee_time/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register(this.toggleView);
  @override
  _RegisterState createState() => _RegisterState(toggleView);
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final Function toggleView;
  final _formKey = GlobalKey<FormState>();
  _RegisterState(this.toggleView);
  String email='';
  String password='';
  String error='';
  dynamic arr;
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
                title: Text('Register',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                backgroundColor: Colors.brown[400],
                elevation: 1.0,
                centerTitle: true,
                actions: <Widget>[
                  FlatButton.icon(onPressed: toggleView, icon: Icon(Icons.person), label: Text('Sign in')),
                ],
              ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical:20,horizontal:50),
        child: Form(key: _formKey,child: Column(
          children: [
            //SizedBox(height: 20.0),
            TextFormField(validator: (val)=>
                val.isEmpty ? 'Enter Email' : null
                ,decoration: InputDecoration(labelText:'Email'),onChanged: (val) {
              setState(() {
                email=val;
              });
            },),

            SizedBox(height: 20.0),
            TextFormField(validator: (val)=>
              val.length < 6 ? 'Password must be of Min 6 characters' : null
            ,obscureText: true,decoration: InputDecoration(labelText:'Password'),onChanged: (val) {
              setState(() {
                password=val;
              });
            },),

            SizedBox(height: 20.0),
            RaisedButton(color: Colors.pink[400],child:Text('Register',style: TextStyle(color:Colors.white),), onPressed: () async {
                if(_formKey.currentState.validate())
                { 
                  setState(() {
                    loading=true;
                  });
                  dynamic res = await _auth.signIn(email, password);
                  if(res.toString().substring(1,6)=='ERROR')
                  {
                    setState(() {
                      loading=false;
                      arr=res.toString().split(',');
                      error=arr[1];   
                    });
                  }
                } 
            },),
            Text(error,style: TextStyle(fontSize:12,color:Colors.red)),
          ],
        ),)
      ),
    );
  }
}