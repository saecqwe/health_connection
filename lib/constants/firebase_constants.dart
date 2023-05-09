import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DB {
  static CollectionReference<Map<String, dynamic>> getUser =
      FirebaseFirestore.instance.collection('users');
  static CollectionReference<Map<String, dynamic>> getActivity =
      FirebaseFirestore.instance.collection('activities');

  static Future<QuerySnapshot> getUserTasks() async{
    return await getUser
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('tasks')
        .get();
  }
}
