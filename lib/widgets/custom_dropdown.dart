import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:health_connection/components/widget_size.dart';
import 'package:health_connection/themes/colors.dart';

class CustomDropDown extends StatelessWidget {
  final String name;
  final String hint;
  final List<String> dropDownOptions;

  final String? Function(String?)? validator;
  final ValueChanged<String?>? onChanged;
  const CustomDropDown({
    Key? key,
    required this.name,
    required this.hint,
    required this.dropDownOptions,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown<String>(
      name: name,
      icon: const Icon(
        // Add this
        Icons.arrow_drop_down, // Add this
        color: Colors.blue, // Add this
      ).paddingOnly(right: 20),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.only(left: 25, top: 15, bottom: 15),
        enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 215, 215, 215)),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.appColor, width: 1.5),
            borderRadius: BorderRadius.circular(10)),
      ),
      items: dropDownOptions
          .map((gender) => DropdownMenuItem(
                alignment: AlignmentDirectional.center,
                value: gender,
                child: Text(
                  gender,
                ),
              ))
          .toList(),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
