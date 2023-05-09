import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:health_connection/themes/colors.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatelessWidget {
  final ValueChanged<DateTime?>? onChanged;
  final String? hint;
  final double? hintSize;
  final String name;
  final InputType? inputType;
  final List<String? Function(DateTime?)> validators;
  final IconData icon;
  final DateFormat dateTimeFormat;
  final DateTime? initialDate;

  const DatePickerWidget({
    Key? key,
    this.onChanged,
    this.hint,
    required this.name,
    required this.validators,
    this.inputType,
    required this.icon,
    required this.dateTimeFormat,
    this.initialDate,
    this.hintSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      // autovalidateMode: AutovalidateMode.always,
      name: name,
      initialValue: initialDate,
      inputType: inputType ?? InputType.time,
      decoration: InputDecoration(
          fillColor: AppColors.transparent,
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
          hintText: hint,
          hintStyle:
              TextStyle(color: AppColors.appColor, fontSize: hintSize ?? 20),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.blackColor),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.appColor, width: 1.5),
              borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.appColor, width: 1.5),
              borderRadius: BorderRadius.circular(10)),
          suffixIcon: Icon(
            icon,
            color: AppColors.appColor,
          )),
      format: dateTimeFormat,

      onChanged: onChanged,
      //  (time) {
      //   if (time != null) {
      //     // HomeController.to.toDate.value =
      //     // DateFormat('yyyy-MM-dd').format(date);
      //   }
      // },
      validator: FormBuilderValidators.compose(validators),
      // initialTime: const TimeOfDay(hour: 8, minute: 0),
    );
  }
}
