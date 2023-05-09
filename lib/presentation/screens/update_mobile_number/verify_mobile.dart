import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:health_connection/components/ui_helper.dart';
import 'package:health_connection/components/widget_size.dart';
import 'package:health_connection/presentation/screens/update_mobile_number/verify_mobile_provider.dart';
import 'package:health_connection/themes/colors.dart';
import 'package:provider/provider.dart';

class VerifyMobile extends StatelessWidget {
  final Map? usrData;
  VerifyMobile(this.usrData, {super.key});

  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                UIHelper.verticalSpaceExtraLarge(),
                const Text(
                  'Link Mobile No.',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor,
                      fontSize: 24),
                ),
                UIHelper.verticalSpaceExtraSmall(),
                const Text(
                  'Please enter your mobile number to link your account.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.veryDarkGreyColor, fontSize: 22),
                ),
                UIHelper.verticalSpaceDoubleExtraLarge(),
                Row(children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'phone_number',
                      decoration: InputDecoration(
                        prefixIcon: SizedBox(
                          width: 125,
                          child: CountryCodePicker(
                            textStyle: const TextStyle(color: Colors.black),
                            initialSelection: context
                                .watch<VerifyMobileProvider>()
                                .selectedCountryCode,
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            favorite: const ['+1'],
                            enabled: true,
                            hideMainText: false,
                            showFlagMain: true,
                            showFlag: true,
                            hideSearch: false,
                            showFlagDialog: true,
                            alignLeft: true,
                            onChanged: (value) {
                              context
                                  .read<VerifyMobileProvider>()
                                  .selectedCountryCode = value.toString();
                            },
                          ),
                        ),
                        hintText: 'Phone Number*',
                        hintStyle: const TextStyle(color: Colors.grey),
                        contentPadding: const EdgeInsets.only(
                            left: 25, top: 15, bottom: 15),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 215, 215, 215)),
                            borderRadius: BorderRadius.circular(50)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.appColor, width: 1.5),
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Phone Number required'),
                      ]),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ]),
                UIHelper.verticalSpaceDoubleExtraLarge(),
                UIHelper.verticalSpaceDoubleExtraLarge(),

                ElevatedButton(
                    onPressed: () async {
                      Map<dynamic, dynamic>? data = usrData;
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate()) {
                        usrData!.addAll({
                          'phone_number':
                              _formKey.currentState!.value['phone_number']
                        });
                        await context
                            .read<VerifyMobileProvider>()
                            .updateMobileNo(data: data!, context: context);
                      }
                    },
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(3),
                        minimumSize: MaterialStateProperty.all(
                            const Size.fromHeight(45)),
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.appColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Complete Login",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            )),
                      ],
                    )),
                // Container(
                //   height: 40,
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: () async {
                //       Map<dynamic, dynamic>? data = usrData;
                //       _formKey.currentState!.save();
                //       if (_formKey.currentState!.validate()) {
                //         usrData!.addAll(
                //             {'mobile': _formKey.currentState!.value['mobile']});
                //         await controller.updateMobile(
                //             data: data!, context: context);
                //       }
                //     },
                //     child: Text(
                //       "Complete Login",
                //     ),
                //     style: ElevatedButton.styleFrom(
                //         elevation: 1,
                //         primary: buttonColor,
                //         // padding: EdgeInsets.symmetric(vertical: 8),
                //         textStyle: TextStyle(
                //           fontSize: 16,
                //           fontWeight: FontWeight.bold,
                //         )),
                //   ),
                // ),
              ],
            )).paddingAll(20),
      ),
    );
  }
}
