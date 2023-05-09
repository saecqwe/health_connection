import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:health_connection/themes/colors.dart';

class CustomCheckBoxGroup extends StatelessWidget {
  final ValueChanged<List<String>?>? onChanged;
  final String? Function(List<String>?)? validator;
  final String name;
  final Widget? hint;
  final List<String> optionList;

  const CustomCheckBoxGroup({
    Key? key,
    this.onChanged,
    this.validator,
    required this.name,
    this.hint,
    required this.optionList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderCheckboxGroup(
      activeColor: AppColors.appColor,

      decoration: InputDecoration(
          enabled: false,
          label: hint,
          //  Text(
          //   hint ?? '',
          //   style: TextStyle(fontSize: 20, color: appDarkColor),
          // ),
          fillColor: const Color.fromARGB(255, 246, 246, 246)),
      // initialValue: ref.watch(attributes),
      name: name,
      validator: validator,

      orientation: OptionsOrientation.vertical,
      onChanged: onChanged,
      options: optionList.map((e) {
        return FormBuilderFieldOption(value: e, child: Text(e));
      }).toList(growable: true),
    );
  }
}
