import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:handy_extensions/handy_extensions.dart';
import 'package:localregex/localregex.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../shared/configs/colors.dart';
import '../../../shared/utils/extensions.dart';
import '../../../shared/widgets/pb_button.dart';
import '../../../shared/widgets/pb_sensitive_text_field.dart';
import '../../../shared/widgets/pb_text_field.dart';
import 'confirm_number.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController mobileNumberController = TextEditingController();

  bool isFormValid() {
    // don't use form.currentState.validate() here because it will trigger the
    // validator for all fields

    final bool valid = mobileNumberController.text.isNotEmpty &&
        LocalRegex.isValidMobile(mobileNumberController.text);
    log('isFormValid: $valid');
    return valid;
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              height: context.height,
              width: context.width,
              padding: EdgeInsets.symmetric(
                horizontal: sx(20),
                vertical: sy(10),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: sy(20),
                      ),
                      Center(
                        child: Image(
                          image:
                              const AssetImage('assets/images/logo-text.png'),
                          height: sy(80),
                        ),
                      ),
                      SizedBox(
                        height: sy(20),
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                          color: PbColors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: sy(15),
                        ),
                      ),
                      Text(
                        'We will send an OTP Verification to you.',
                        style: TextStyle(
                          color: PbColors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: sy(10),
                        ),
                      ),
                      SizedBox(
                        height: sy(20),
                      ),
                      PbTextField(
                        controller: mobileNumberController,
                        hint: 'Mobile Number',
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your mobile number';
                          }

                          if (!LocalRegex.isValidMobile(value)) {
                            return 'Please enter a valid mobile number';
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        height: sy(20),
                      ),
                      PbButton(
                        // isDisabled: !isFormValid(),
                        disabledBtnColor: PbColors.grey.withOpacity(0.4),
                        text: 'Continue',
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            context.goTo(
                              page: ConfirmMobileNumberPage(
                                phone: mobileNumberController.text,
                              ),
                            );
                          }
                        },
                      ),
                      // SizedBox(
                      //   height: sy(20),
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       'Already have an account? ',
                      //       style: TextStyle(
                      //         color: PbColors.black,
                      //         fontWeight: FontWeight.w400,
                      //         fontSize: sy(10),
                      //       ),
                      //     ),
                      //     Text(
                      //       'Login',
                      //       style: TextStyle(
                      //         color: PbColors.blue,
                      //         fontWeight: FontWeight.w700,
                      //         fontSize: sy(10),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
