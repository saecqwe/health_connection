import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:health_connection/components/date_picker_widget.dart';
import 'package:health_connection/components/globle_variables.dart';
import 'package:health_connection/components/widget_size.dart';
import 'package:health_connection/constants/firebase_constants.dart';
import 'package:health_connection/themes/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../activity_scale_screen.dart/activity_scale_provider.dart';

class TaskAppointment extends StatefulWidget {
  const TaskAppointment({super.key});

  @override
  State<TaskAppointment> createState() => _TaskAppointmentState();
}
class _TaskAppointmentState extends State<TaskAppointment> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ActivityScaleProvider ref =
        Provider.of<ActivityScaleProvider>(context, listen: false);

    return Consumer<ActivityScaleProvider>(
      builder: (context, value, child) {
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
              print(ref.addedTasksList);
              return Column(
                children: [
                  Text( "Consider making appointments in your calendar for these Mental Health Connections and schedule a time each week in your calendar to revisit this activity and repeat Steps 1 through 5 to renew or create new Mental Health Connections for the following week.",
                   style: basicStyle(
                        size: 16,
                        color: AppColors.blackColor,
                       ), ).paddingAll(20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: ref.addedTasksList.length,
                      itemBuilder: (context, index) {
                        var task = ref.addedTasksList[index];
                        var date = task['date'];
                        print("this is task : " + task.toString());
                                      print("this is datee : " + date.toString());
                  
                        return Card(
                          child: ListTile(
                            minVerticalPadding: 2,
                            title: Text(ref.addedTasksList[index]['task_name']),
                            subtitle: Text(ref.addedTasksList[index]['date'] != null
                                ? 'Date: ${DateFormat('MMM d, yyyy').format(ref.addedTasksList[index]['date'].toDate())}\nTime: ${DateFormat('h:mm a').format(ref.addedTasksList[index]['date'].toDate())}'
                                : 'No date selected'),
                  
                            trailing: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () async {
                                final selectedDateTime = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(DateTime.now().year + 5),
                                );
                                if (selectedDateTime != null) {
                                  final selectedTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (selectedTime != null) {
                                    final dateTime = DateTime(
                                      selectedDateTime.year,
                                      selectedDateTime.month,
                                      selectedDateTime.day,
                                      selectedTime.hour,
                                      selectedTime.minute,
                                    );
                                 await    ref.addDateTimeToTask(ref.addedTasksList[index]['task_name'], dateTime);
                                  }
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }
}
