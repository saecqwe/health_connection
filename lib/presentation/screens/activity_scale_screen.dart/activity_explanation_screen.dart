import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:health_connection/components/custom_buttons.dart';
import 'package:health_connection/components/device_size_helper.dart';
import 'package:health_connection/components/globle_variables.dart';
import 'package:health_connection/components/widget_size.dart';
import 'package:health_connection/constants/firebase_constants.dart';
import 'package:health_connection/presentation/screens/activity_scale_screen.dart/activity_scale_provider.dart';
import 'package:health_connection/themes/colors.dart';
import 'package:health_connection/utils/ui_helper.dart';
import 'package:health_connection/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class ActivityExplanationScreen extends StatelessWidget {
  const ActivityExplanationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ActivityScaleProvider>(builder: (context, ref, child) {
      return StreamBuilder(
          stream: DB.getActivity.doc('FEYcZN6uikDiRYqqBb9m').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text(
                  'Loading...',
                ),
              );
            } else {
              var snapshotData = snapshot.data?.data();
              // ref.activities = snapshotData?['activity_list'];

              return Column(
                children: [
                  Text("Below each Health Circle area, list items that you do, or can do, to positively impact your health." , style:   basicStyle(size: 20)).paddingAll(20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshotData?['activity_list'].length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = snapshotData?['activity_list'][index];
                        return Card(
                            child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  maxRadius: 35,
                                  minRadius: 35,
                                  backgroundImage: NetworkImage(data[
                                      "activity_image"]), // No matter how big it is, it won't overflow
                                ),
                                UIHelper.horizontalSpaceMedium(),
                                Expanded(
                                  child: Text(
                                    data['activity_name'],
                                    style: basicStyle(
                                        size: 20,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.darkBlueColor),
                                  ),
                                ),
                                CustomButtons.customElevatedButton(
                                    onTap: () {
                                      addActivityItem(
                                          ref: ref, name: data['activity_name'] , activityIndex: index);
                                    },
                                    buttonColor: Colors.amber,
                                    widget: Row(
                                      children: [
                                        const Icon(
                                          Icons.add,
                                          color: AppColors.blackColor,
                                        ),
                                        Text(
                                          "Add",
                                          style: basicStyle(
                                              color: AppColors.blackColor,
                                              size: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    )),
                                Tooltip(
                                    triggerMode: TooltipTriggerMode.tap,
                                    message: data["definition"],
                                    showDuration: const Duration(milliseconds: 3000),
                                    padding: const EdgeInsets.only(
                                        bottom: 10, top: 10, left: 10, right: 10),
                                    margin: EdgeInsets.only(
                                        left: getWidth / 8, right: getWidth / 8),
                                    child: const IconButton(
                                        onPressed: null,
                                        icon: Icon(Icons.info_outline))),
                              ],
                            ),
                            UIHelper.verticalSpaceMedium(),
                            FutureBuilder( future: DB.getUserTasks(),
                        builder: (context, snapshot2) {
                          if (!snapshot2.hasData) {
                            return const Center(
                              child: Text(
                    'Loading...',
                              ),
                            );
                          } else {
                            
                            ref.addedTasksList = [];
                            snapshot2.data!.docs.forEach((task) {
                              ref.addedTasksList.add(task.data() as Map<String, dynamic>);
                            });
                  
                            return ListView.builder(
                              addAutomaticKeepAlives: true,
                              shrinkWrap: true,
                              itemCount: ref.addedTasksList.length,
                              itemBuilder: (BuildContext context, int index2) {
                                
                                var dd = ref.addedTasksList[index2];
                                print(dd.toString());
                                return Visibility(
                                  visible:
                                      (dd['activities'] as List).any((element) => element['activity_name']== data['activity_name']),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 202, 202, 202))),
                                    child: ListTile(
                                      title: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            dd['task_name'],
                                            style: basicStyle(
                                                size: 16,
                                                color: AppColors.darkBlueColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          UIHelper.verticalSpaceSmall(),
                                          // Text(
                                          //   getDate(
                                          //     dd['activity_data']['date_time'],
                                          //   ),
                                          //   style: basicStyle(
                                          //       size: 14,
                                          //       color: AppColors.midGreyColor,
                                          //       fontWeight: FontWeight.normal),
                                          // ),
                                        ],
                                      ).paddingOnly(top: 10, bottom: 10),
                                      trailing: IconButton(
                                          onPressed: () {
                                            ref.removeItemFromActivityList(index2);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: AppColors.redColor,
                                          )),
                                    ),
                                  ).paddingOnly(bottom: 10),
                                );
                              },
                            );
                        
                            
                      } } )
                          
                          ],
                        ).paddingAll(20));
                      },
                    ),
                  ),
                ],
              );
            }
          });
    });
    // return Scaffold(
    //     appBar: AppBar(
    //       title: const Text("Activity Explanation"),
    //     ),
    //     bottomNavigationBar: CustomButtons.customElevatedButton(
    //             onTap: () {
    //               pushPageAsWidget(pageName: const LineScreen());
    //             },
    //             borderRadius: BorderRadius.circular(50),
    //             widget: Text(
    //               'Continue',
    //               style: basicStyle(
    //                   color: AppColors.whiteColor,
    //                   fontWeight: FontWeight.normal,
    //                   size: 18),
    //             ).paddingAll(15))
    //         .paddingOnly(bottom: 10, left: 10, right: 10),
    //     body: Consumer<ActivityScaleProvider>(
    //       builder: (context, ref, child) {
    //         return StreamBuilder(
    //             stream: DB.getActivity.doc('FEYcZN6uikDiRYqqBb9m').snapshots(),
    //             builder: (context, snapshot) {
    //               if (!snapshot.hasData) {
    //                 return const Center(
    //                   child: Text(
    //                     'Loading...',
    //                   ),
    //                 );
    //               } else {
    //                 var snapshotData = snapshot.data?.data();
    //                 // ref.activities = snapshotData?['activity_list'];
    //                 print(ref.activities.first.toString());

    //                 return ListView.builder(
    //                   itemCount: snapshotData?['activity_list'].length,
    //                   itemBuilder: (BuildContext context, int index) {
    //                     var data = snapshotData?['activity_list'][index];

    //                     return Card(
    //                         child: Column(
    //                       children: [
    //                         Row(
    //                           children: [
    //                             CircleAvatar(
    //                               maxRadius: 35,
    //                               minRadius: 35,
    //                               backgroundImage: NetworkImage(data[
    //                                   "activity_image"]), // No matter how big it is, it won't overflow
    //                             ),
    //                             UIHelper.horizontalSpaceMedium(),
    //                             Expanded(
    //                               child: Text(
    //                                 data['activity_name'],
    //                                 style: basicStyle(
    //                                     size: 20,
    //                                     fontWeight: FontWeight.w500,
    //                                     color: AppColors.darkBlueColor),
    //                               ),
    //                             ),
    //                             CustomButtons.customElevatedButton(
    //                                 onTap: () {
    //                                   addActivityItem(
    //                                       ref: ref,
    //                                       name: data['activity_name']);
    //                                 },
    //                                 buttonColor: Colors.amber,
    //                                 widget: Row(
    //                                   children: [
    //                                     const Icon(
    //                                       Icons.add,
    //                                       color: AppColors.blackColor,
    //                                     ),
    //                                     Text(
    //                                       "Add",
    //                                       style: basicStyle(
    //                                           color: AppColors.blackColor,
    //                                           size: 16,
    //                                           fontWeight: FontWeight.normal),
    //                                     ),
    //                                   ],
    //                                 )),
    //                             Tooltip(
    //                                 triggerMode: TooltipTriggerMode.tap,
    //                                 message: data["definition"],
    //                                 showDuration:
    //                                     const Duration(milliseconds: 3000),
    //                                 padding: const EdgeInsets.only(
    //                                     bottom: 10,
    //                                     top: 10,
    //                                     left: 10,
    //                                     right: 10),
    //                                 margin: EdgeInsets.only(
    //                                     left: getWidth / 8,
    //                                     right: getWidth / 8),
    //                                 child: const IconButton(
    //                                     onPressed: null,
    //                                     icon: Icon(Icons.info_outline))),
    //                           ],
    //                         ),
    //                         UIHelper.verticalSpaceMedium(),
    //                         ListView.builder(
    //                           shrinkWrap: true,
    //                           itemCount: ref.addedActivityList.length,
    //                           itemBuilder: (BuildContext context, int index2) {
    //                             var dd = ref.addedActivityList[index2];
    //                             return Visibility(
    //                               visible: dd['activity_name'] ==
    //                                   data['activity_name'],
    //                               child: Container(
    //                                 decoration: BoxDecoration(
    //                                     borderRadius: BorderRadius.circular(10),
    //                                     border: Border.all(
    //                                         color: const Color.fromARGB(
    //                                             255, 202, 202, 202))),
    //                                 child: ListTile(
    //                                   title: Column(
    //                                     crossAxisAlignment:
    //                                         CrossAxisAlignment.start,
    //                                     children: [
    //                                       Text(
    //                                         dd['activity_data']['detail'],
    //                                         style: basicStyle(
    //                                             size: 16,
    //                                             color: AppColors.darkBlueColor,
    //                                             fontWeight: FontWeight.w500),
    //                                       ),
    //                                       UIHelper.verticalSpaceSmall(),
    //                                       Text(
    //                                         getDate(
    //                                           dd['activity_data']['date_time'],
    //                                         ),
    //                                         style: basicStyle(
    //                                             size: 14,
    //                                             color: AppColors.midGreyColor,
    //                                             fontWeight: FontWeight.normal),
    //                                       ),
    //                                     ],
    //                                   ).paddingOnly(top: 10, bottom: 10),
    //                                   trailing: IconButton(
    //                                       onPressed: () {
    //                                         ref.removeItemFromActivityList(
    //                                             index2);
    //                                       },
    //                                       icon: const Icon(
    //                                         Icons.delete,
    //                                         color: AppColors.redColor,
    //                                       )),
    //                                 ),
    //                               ).paddingOnly(bottom: 10),
    //                             );
    //                           },
    //                         ),
    //                       ],
    //                     ).paddingAll(20));
    //                   },
    //                 );
    //               }
    //             });

    //       },
    //     ));
  }
}

addActivityItem({required ActivityScaleProvider ref, required String name , required int activityIndex}) {
  return showDialog(
      context: navigatorKey.currentContext!,
      builder: (_) {
        return AlertDialog(
          title: const Text("Add Activity"),
          content: SizedBox(
            height: getHeight / 1.8,
            width: getWidth,
            child: SingleChildScrollView(
              child: FormBuilder(
                key: ref.key2,
                child: Column(
                  children: [
                    UIHelper.verticalSpaceMedium(),
                    // DatePickerWidget(
                    //   name: 'date_time',
                    //   hint: 'Date Time',
                    //   dateTimeFormat: DateFormat('dd-MMM-yyyy'),
                    //   inputType: InputType.date,
                    //   icon: Icons.date_range,
                    //   validators: [
                    //     FormBuilderValidators.required(
                    //         errorText: 'Date Time Required'),
                    //   ],
                    // ),
                   
                    // UIHelper.verticalSpaceLarge(),
                    CustomInput(
                      hint: "Enter activity detail here",
                      name: 'task_name',
                      maxLines: 8,
                      upperHeight: 0,
                      lowerHeight: 12,
                      textInputType: TextInputType.text,
                      validators: [
                        FormBuilderValidators.required(
                            errorText: 'Activity Name required'),
                      ],
                      inputBorder: const OutlineInputBorder(),
                    ),
                    UIHelper.verticalSpaceExtraLarge(),
                    ElevatedButton(
                        onPressed: () async{
                        await  ref.addDataToActivityList(name: name , activityIndex: activityIndex);
                          
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
