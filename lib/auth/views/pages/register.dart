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
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isFormValid() {
    // don't use form.currentState.validate() here because it will trigger the
    // validator for all fields

    final bool valid = firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        mobileNumberController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        LocalRegex.isValidMobile(mobileNumberController.text) &&
        LocalRegex.isPassword(passwordController.text);
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
                        'Register',
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
                        controller: firstNameController,
                        hint: 'First Name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: sy(10),
                      ),
                      PbTextField(
                        controller: lastNameController,
                        hint: 'Last Name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: sy(10),
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
                        height: sy(10),
                      ),
                      PbSensitiveTextField(
                        controller: passwordController,
                        hint: 'Password',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }

                          if (!LocalRegex.isPassword(value)) {
                            return 'Please enter a valid password';
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
                                isLogin: false,
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                phone: mobileNumberController.text,
                                password: passwordController.text,
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: sy(20),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: TextStyle(
                              color: PbColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: sy(10),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.goTo(page: const LoginPage());
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: PbColors.blue,
                                fontWeight: FontWeight.w700,
                                fontSize: sy(10),
                              ),
                            ),
                          ),
                        ],
                      ),
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
