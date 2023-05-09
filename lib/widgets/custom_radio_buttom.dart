import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:health_connection/components/ui_helper.dart';
import 'package:health_connection/themes/colors.dart';

class CustomRadioButtonWithText extends StatelessWidget {
  final ValueChanged<String?>? onChanged;
  final String? Function(String?)? validator;
  final String name;
  final String title;
  final IconData? icon;
  final List<String> optionList;
  const CustomRadioButtonWithText({
    Key? key,
    this.onChanged,
    required this.name,
    required this.title,
    required this.optionList,
    this.validator,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 6,
          child: Row(
            children: [
              Visibility(
                  visible: icon == null ? false : true,
                  child: Row(
                    children: [
                      Icon(icon),
                      UIHelper.horizontalSpaceMedium(),
                    ],
                  )),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: FormBuilderRadioGroup(
            decoration: const InputDecoration(
                fillColor: AppColors.whiteColor,
                border: InputBorder.none,
                enabledBorder: InputBorder.none),
            onChanged: onChanged,
            name: name,
            validator: validator,
            options: optionList
                .map((lang) => FormBuilderFieldOption(value: lang))
                .toList(growable: false),
          ),
        )
      ],
    );
  }
}
