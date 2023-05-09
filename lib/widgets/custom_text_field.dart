import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:health_connection/themes/colors.dart';

import '../utils/ui_helper.dart';

class CustomInput extends StatelessWidget {
  final ValueChanged<String?>? onChanged;
  final String? hint;
  final double? hintSize;
  final String? name;
  final int? maxLines;
  final double? upperHeight;
  final double? lowerHeight;
  final double? circular;
  final String? initialValue;
  final Widget? suffix;
  final TextCapitalization? textCapitalization;
  final Widget? icon;
  final bool? readOnly;
  final List<String? Function(String?)>? validators;
  final TextInputType textInputType;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextEditingController? controller;
  final Function(String?)? onSubmit;
  final InputBorder? inputBorder;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;

  const CustomInput(
      {Key? key,
      this.onChanged,
      this.hint,
      this.inputBorder,
      required this.name,
      this.validators,
      required this.textInputType,
      this.maxLines,
      this.upperHeight,
      this.lowerHeight,
      this.icon,
      this.textCapitalization,
      this.initialValue,
      this.suffix,
      this.hintSize,
      this.circular,
      this.hintStyle,
      this.readOnly,
      this.enabledBorder,
      this.focusedBorder,
      this.controller,
      this.onSubmit,
      this.textStyle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UIHelper.verticalSpace(upperHeight ?? 8.0),
        FormBuilderTextField(
          // autofillHints: const [AutofillHints.name],
          controller: controller,
          onSubmitted: onSubmit,
          name: name!,
          initialValue: initialValue,
          maxLines: maxLines ?? 1,
          onChanged: onChanged,
          readOnly: readOnly ?? false,
          style: textStyle ??
              TextStyle(color: AppColors.appColor, fontSize: hintSize ?? 20),

          decoration: InputDecoration(
              fillColor: AppColors.transparent,
              hintText: hint,
              suffixIcon: suffix,
              hintStyle: hintStyle ??
                  TextStyle(
                      color: AppColors.appColor, fontSize: hintSize ?? 20),
              contentPadding:
                  const EdgeInsets.only(left: 25, top: 15, bottom: 15),
              enabledBorder: enabledBorder ??
                  OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.blackColor),
                      borderRadius: BorderRadius.circular(circular ?? 10)),
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.blackColor),
                  borderRadius: BorderRadius.circular(circular ?? 10)),
              focusedBorder: focusedBorder ??
                  OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.appColor, width: 1.5),
                      borderRadius: BorderRadius.circular(circular ?? 10)),
              prefixIcon: icon),
          validator: FormBuilderValidators.compose(validators ?? []),
          keyboardType: textInputType,
          textCapitalization: textCapitalization ?? TextCapitalization.words,
        ),
        UIHelper.verticalSpace(lowerHeight ?? 8),
      ],
    );
  }
}
