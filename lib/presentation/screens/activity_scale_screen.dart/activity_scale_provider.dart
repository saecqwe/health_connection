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
  List<Map<String, dynamic>> addedTasksList = [];
  List userActivities = [];

  addDataToActivityList({required String name, required int activityIndex}) {
    if (key?.currentState?.saveAndValidate() ?? false) {
      addedTasksList.add({
        'activities': [
          {"activity_id": activityIndex, "activity_name": name}
        ],
        'task_name': key?.currentState!.value['task_name']
      });
      backPage();
    }
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
