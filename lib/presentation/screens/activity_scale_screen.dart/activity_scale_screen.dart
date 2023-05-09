import 'package:flutter/material.dart';
import 'package:health_connection/components/device_size_helper.dart';
import 'package:health_connection/components/globle_variables.dart';
import 'package:health_connection/components/widget_size.dart';
import 'package:health_connection/constants/firebase_constants.dart';
import 'package:health_connection/presentation/screens/activity_scale_screen.dart/activity_scale_provider.dart';
import 'package:health_connection/themes/colors.dart';
import 'package:health_connection/utils/ui_helper.dart';
import 'package:provider/provider.dart';

class ActivityScaleScreen extends StatelessWidget {
  const ActivityScaleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ActivityScaleProvider ref =
        Provider.of<ActivityScaleProvider>(context, listen: false);

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

            ref.activities = snapshotData?['activity_list'];

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Using a scale from 1 (not much at all) to 10 (very much), indicate how intentional you are with incorporating each of the Health Circles into your life.",
                    style: basicStyle(size: 20),
                  ).paddingAll(22),
                ),
                Expanded(
                  flex: 5,
                  // height: MediaQuery.of(context).size.height * 0.6,
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
                                maxRadius: 40,
                                minRadius: 40,
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
                              Tooltip(
                                  triggerMode: TooltipTriggerMode.tap,
                                  message: data["definition"],
                                  showDuration:
                                      const Duration(milliseconds: 3000),
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 10, left: 10, right: 10),
                                  margin: EdgeInsets.only(
                                      left: getWidth / 8, right: getWidth / 8),
                                  child: const IconButton(
                                      onPressed: null,
                                      icon: Icon(Icons.info_outline)))
                            ],
                          ),
                          UIHelper.verticalSpaceLarge(),
                          MarkScale(
                            onMarkSelected: (p0) {
                              if (ref.userActivities.any((element) =>
                                  element['activityId'] == index)) {
                                ref.userActivities.firstWhere((element) =>
                                    element['activityId'] ==
                                    index)['score'] = p0;
                              } else {
                                ref.userActivities
                                    .add({"activityId": index, "score": p0});
                              }


                              ref.activities[index]['score'] = p0;
                            },
                          ),
                        ],
                      ).paddingAll(20));
                    },
                  ),
                ),
              ],
            );
          }
        });

    // return Scaffold(
    //     appBar: AppBar(
    //       title: const Text("Activity Scale"),
    //     ),
    //     bottomNavigationBar: CustomButtons.customElevatedButton(
    //             onTap: () {
    //               pushPage(pageName: Routes.activityExplanation);
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
    //     body: StreamBuilder(
    //         stream: DB.getActivity.doc('FEYcZN6uikDiRYqqBb9m').snapshots(),
    //         builder: (context, snapshot) {
    //           if (!snapshot.hasData) {
    //             return const Center(
    //               child: Text(
    //                 'Loading...',
    //               ),
    //             );
    //           } else {
    //             var snapshotData = snapshot.data?.data();

    //             ref.activities = snapshotData?['activity_list'];

    //             return ListView.builder(
    //               itemCount: snapshotData?['activity_list'].length,
    //               itemBuilder: (BuildContext context, int index) {
    //                 var data = snapshotData?['activity_list'][index];
    //                 return Card(
    //                     child: Column(
    //                   children: [
    //                     Row(
    //                       children: [
    //                         CircleAvatar(
    //                           maxRadius: 40,
    //                           minRadius: 40,
    //                           backgroundImage: NetworkImage(data[
    //                               "activity_image"]), // No matter how big it is, it won't overflow
    //                         ),
    //                         UIHelper.horizontalSpaceMedium(),
    //                         Expanded(
    //                           child: Text(
    //                             data['activity_name'],
    //                             style: basicStyle(
    //                                 size: 20,
    //                                 fontWeight: FontWeight.w500,
    //                                 color: AppColors.darkBlueColor),
    //                           ),
    //                         ),
    //                         Tooltip(
    //                             triggerMode: TooltipTriggerMode.tap,
    //                             message: data["definition"],
    //                             showDuration:
    //                                 const Duration(milliseconds: 3000),
    //                             padding: const EdgeInsets.only(
    //                                 bottom: 10, top: 10, left: 10, right: 10),
    //                             margin: EdgeInsets.only(
    //                                 left: getWidth / 8, right: getWidth / 8),
    //                             child: const IconButton(
    //                                 onPressed: null,
    //                                 icon: Icon(Icons.info_outline)))
    //                       ],
    //                     ),
    //                     UIHelper.verticalSpaceLarge(),
    //                     MarkScale(
    //                       onMarkSelected: (p0) {
    //                         print(ref.activities.length.toString());
    //                         ref.activities[index]['score'] = p0;
    //                       },
    //                     ),
    //                   ],
    //                 ).paddingAll(20));
    //               },
    //             );
    //           }
    //         }));
  }
}

class MarkScale extends StatefulWidget {
  final Function(int) onMarkSelected;

  const MarkScale({super.key, required this.onMarkSelected});

  @override
  _MarkScaleState createState() => _MarkScaleState();
}

class _MarkScaleState extends State<MarkScale> {
  int _selectedMark = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(10, (index) {
        return InkWell(
          onTap: () {
            setState(() {
              _selectedMark = index + 1;
            });
            widget.onMarkSelected(_selectedMark);
          },
          child: Container(
            width: 25.0,
            height: 25.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index < _selectedMark ? Colors.amber : AppColors.greyColor,
            ),
            child: Center(
              child: Text(
                "${index + 1}",
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: index < _selectedMark ? Colors.black : Colors.white,
                ),
              ),
            ),
          ).paddingAll(3),
        );
      }),
    );
  }
}
