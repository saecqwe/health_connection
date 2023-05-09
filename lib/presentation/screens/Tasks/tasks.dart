import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:health_connection/components/device_size_helper.dart';
import 'package:health_connection/components/globle_variables.dart';
import 'package:health_connection/components/ui_helper.dart';
import 'package:health_connection/constants/firebase_constants.dart';
import 'package:health_connection/themes/colors.dart';
import 'package:health_connection/widgets/custom_text_field.dart';

import 'package:provider/provider.dart';

import '../activity_scale_screen.dart/activity_scale_provider.dart';

class Tasks extends StatelessWidget {
  const Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    ActivityScaleProvider ref =
        Provider.of<ActivityScaleProvider>(context, listen: false);

    return FutureBuilder(
      future: DB.getUserTasks(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Text(
              'Loading...',
            ),
          );
        } else {
          ref.addedTasksList = [];
          snapshot.data!.docs.forEach((task) {
            ref.addedTasksList.add(task.data() as Map<String, dynamic>);
          });
          return ListView.builder(
            itemCount: ref.addedTasksList.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  minVerticalPadding: 2,
                  title: Text(ref.addedTasksList[index]['task_name']),
                  isThreeLine: true,
                  subtitle: SizedBox(
                    height: 30,
                    width: double.infinity,
                    child: Center(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 10,
                            child: ListView.separated(
                                separatorBuilder: (context, index) => const Text(',\t'),
                              scrollDirection: Axis.horizontal,
                              itemCount: ref
                                  .addedTasksList[index]['activities'].length,
                              itemBuilder: (context, index2) {
                                return Text(ref.addedTasksList[index]
                                    ['activities'][index2]['activity_name']);
                              },
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: IconButton(
                                  onPressed: () {
                                    addActivityToTAsk(
                                        ref.addedTasksList[index], ref);
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    size: 20,
                                  )))
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

addActivityToTAsk(something, ActivityScaleProvider ref) {
  return showDialog(
      context: navigatorKey.currentContext!,
      builder: (_) {
        return AlertDialog(
          title: const Text("Add activity"),
          content: SizedBox(
            height: getHeight / 1.9,
            width: getWidth,
            child: SingleChildScrollView(
              child: FormBuilder(
                key: ref.key,
                child: Column(
                  children: [
                    UIHelper.verticalSpaceMedium(),
                    FormBuilderDropdown(
                      autovalidateMode: AutovalidateMode.always,
                        name: 'name',
                        decoration: InputDecoration(
                          labelText: 'Select Activity to Add',
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                        items: (ref.activities as List).map((activity) {
                         
                          return DropdownMenuItem(
                            value: activity,
                            child: Text(activity['activity_name']),
                          );
                        }).toList()),
                    UIHelper.verticalSpaceExtraLarge(),
                    ElevatedButton(
                        onPressed: () async{
                       
                          ref.addedTasksList
                              .firstWhere((element) =>
                                  element['task_name'] ==
                                  something['task_name'])['activities']
                              .add({
                            "activity_id": ref.activities.indexOf(
                               ref.key!.currentState!.fields.values.first.value),
                            "activity_name":
                                ref.key!.currentState!.fields.values.first.value['activity_name']
                          });
                       await   ref.uploadTasksToActivites();
                          backPage();
                        },
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(3),
                            minimumSize: MaterialStateProperty.all(
                                const Size.fromHeight(45)),
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.appColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Add Activity",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.whiteColor)),
                            UIHelper.horizontalSpaceSmall(),
                            const Icon(
                              Icons.arrow_circle_right_outlined,
                              color: AppColors.whiteColor,
                              size: 30,
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
