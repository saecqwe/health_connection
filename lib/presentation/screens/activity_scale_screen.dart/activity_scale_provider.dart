import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:health_connection/components/globle_variables.dart';
import 'package:health_connection/components/show_toast.dart';
import 'package:health_connection/constants/firebase_constants.dart';

class ActivityScaleProvider extends ChangeNotifier {
  dynamic activities;
  GlobalKey<FormBuilderState>? key = GlobalKey<FormBuilderState>();
    GlobalKey<FormBuilderState>? key2 = GlobalKey<FormBuilderState>();

  List<Map<String, dynamic>> addedTasksList = [];
  List userActivities = [];

  Future<int> getActivityScore(int index) async {
  try {
    var doc = await DB.getUser
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('activities')
        .doc(index.toString())
        .get();
    return doc.get('score') ?? 0; // return score or 0 if it's null
  } catch (e) {
    print('Error fetching activity score: $e');
    return 0; // return 0 if there's an error
  }
}


  addDataToActivityList({required String name, required int activityIndex}) async{
    print("this name should be added : $name");
    print("this  name too : ${key2?.currentState!.fields['task_name']!.value}");
    if (key2?.currentState?.saveAndValidate() ?? false) {
      addedTasksList.add({
        'activities': [
          {"activity_id": activityIndex, "activity_name": name}
        ],
        'task_name': key2?.currentState!.fields['task_name']!.value
      });
     await uploadTasksToActivites();
      backPage();
    }
    // notifyListeners();
    print("Notified Listners to update ${addedTasksList.toString()} ");
  }

  addDateTimeToTask(String task_name, var date) async {
    await DB.getUser
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('tasks')
        .doc(task_name)
        .set({'date': date}, SetOptions(merge: true));

    notifyListeners();
  }

  uploadTasksToActivites() async {
    if (addedTasksList.isNotEmpty) {
      for (var task in addedTasksList) {
        await DB.getUser
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('tasks')
            .doc(task['task_name'])
            .set(task, SetOptions(merge: true));
      }
      notifyListeners();
    }
  }

  uploadUserActivitiesToFirebase() async {
    if (userActivities.isNotEmpty) {
      for (var activity in userActivities) {
        await DB.getUser
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("activities")
            .doc(activity['activityId'].toString())
            .set(activity, SetOptions(merge: true));
      }
      notifyListeners();
    }
  }

  removeItemFromActivityList(index) {
    addedTasksList.removeAt(index);
    showToast('Removed');
    notifyListeners();
  }
}
