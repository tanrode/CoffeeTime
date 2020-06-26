import 'package:coffee_time/models/user.dart';
import 'package:coffee_time/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService
{
  final FirebaseAuth _auth = FirebaseAuth.instance;

//extract the user ID from the FirebaseUser object
  User _getUserID(FirebaseUser user)
  {
    return user!=null ? User(uid: user.uid):null;
  }

// listen for change in Authentication
  Stream<User> get changeAuth{
    return _auth.onAuthStateChanged.map(_getUserID);
  }  

//anonymous sign in
  Future signInAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _getUserID(user);
    }
    catch(exc)
    {
      print(exc.toString());
      return null;
    }
  }

//Sign in with email and password
  Future signInWithEmail(String email,String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _getUserID(user);
    }
    catch(exc){
      //print(exc.toString().substring(17));
      return null;
    }
  }  

//Register with email and password
  Future signIn(String email,String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseService(uid:user.uid).updateUserdata('0', 'New Member', 100);
      return _getUserID(user);
    }
    catch(exc){
      print(exc.toString().substring(17));
      return exc.toString().substring(17);
    }
  }  

//Signout
  Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(exc){
      print(exc.toString());
      return null;
    }
  }
  
}