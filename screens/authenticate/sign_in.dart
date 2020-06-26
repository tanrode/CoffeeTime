import 'package:coffee_time/services/auth.dart';
import 'package:coffee_time/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn(this.toggleView);
  @override
  _SignInState createState() => _SignInState(toggleView);
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final Function toggleView;
  final _formkey = GlobalKey<FormState>();

  _SignInState(this.toggleView);
  String email='';
  String password='';
  String error='';
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
                title: Text('Sign in',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                backgroundColor: Colors.brown[400],
                elevation: 1.0,
                centerTitle: true,
                actions: <Widget>[
                  FlatButton.icon(onPressed: toggleView, icon: Icon(Icons.person), label: Text('Register')),
                ],
            ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical:20,horizontal:50),
        child: Form(
            key: _formkey,
            child: Column(
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
            RaisedButton(color: Colors.pink[400],child:Text('Sign in',style: TextStyle(color:Colors.white),), onPressed: () async {
                if(_formkey.currentState.validate())
                { 
                  setState(() {
                    loading=true;
                  });
                  dynamic result= await _auth.signInWithEmail(email, password);
                  if(result==null)
                  {
                    setState(() {
                      loading=false;
                      error='Invalid Username/Password';
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