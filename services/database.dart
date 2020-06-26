import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_time/models/brew.dart';
import 'package:coffee_time/models/user.dart';

class DatabaseService 
{
  final String uid;
  final CollectionReference chaiInfo = Firestore.instance.collection('beverages');
  DatabaseService({this.uid});

  Future updateUserdata(String sugar,String name,int str) async
  {
    return await chaiInfo.document(uid).setData({
      'sugar':sugar,
      'name':name,
      'strength':str,
    });
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot)
  {
    return snapshot.documents.map((doc){
      return Brew(
        name: doc.data['name'] ?? '',
        strength: doc.data['strength'] ?? 0,
        sugar: doc.data['sugar'] ?? '0',
      );
    }).toList();
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot)
  {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugar: snapshot.data['sugar'],
      strength: snapshot.data['strength'],
    );
  }

  //Stream for beverages document
  Stream<List<Brew>> get beverages{
    return chaiInfo.snapshots().map(_brewListFromSnapshot);
  }

  //Stream for UserInfo from FireStore Document
  Stream<UserData> get userData{
    return chaiInfo.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}