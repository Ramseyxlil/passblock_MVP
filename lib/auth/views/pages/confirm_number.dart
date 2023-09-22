import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handy_extensions/handy_extensions.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../passblock/views/pages/pass_block.dart';
import '../../../shared/configs/colors.dart';
import '../../../shared/utils/extensions.dart';
import '../../../shared/widgets/pb_button.dart';
import '../../state/login_bloc.dart';
import '../../state/otp_bloc.dart';
import '../../state/register_bloc.dart';

class ConfirmMobileNumberPage extends StatefulWidget {
  const ConfirmMobileNumberPage({
    required this.phone,
    this.isLogin = true,
    this.firstName,
    this.lastName,
    this.password,
    super.key,
  });

  final bool isLogin;
  final String phone;
  final String? firstName;
  final String? lastName;
  final String? password;

  @override
  State<ConfirmMobileNumberPage> createState() =>
      _ConfirmMobileNumberPageState();
}

class _ConfirmMobileNumberPageState extends State<ConfirmMobileNumberPage> {
  final OtpFieldController otpFieldController = OtpFieldController();

  late OtpBloc otpBloc;
  late LoginBloc loginBloc;
  late RegisterBloc registerBloc;

  int otpLen = 6;
  String otp = '';

  @override
  void initState() {
    otpBloc = OtpBloc();
    loginBloc = LoginBloc();
    registerBloc = RegisterBloc();
    otpBloc.send(phone: widget.phone);
    super.initState();
  }

  bool isFormValid() {
    final bool valid = otp.length == otpLen;
    log('isFormValid: $valid');
    return valid;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => otpBloc),
        BlocProvider(create: (context) => loginBloc),
        BlocProvider(create: (context) => registerBloc),
      ],
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return MultiBlocListener(
            listeners: [
              BlocListener<OtpBloc, OtpState>(
                listener: (context, otpSt) {
                  if (otpSt is OtpVerified) {
                    Fluttertoast.showToast(
                      msg: 'Success',
                      backgroundColor: PbColors.green,
                    );
                    if (widget.isLogin) {
                      loginBloc.fetch(credential: otpSt.credential);
                    } else {
                      registerBloc.fetch(
                        firstName: widget.firstName!,
                        lastName: widget.lastName!,
                        password: widget.password!,
                        phone: widget.phone,
                        credential: otpSt.credential,
                      );
                    }
                  }
                  if (otpSt is OtpFailed) {
                    Fluttertoast.showToast(
                      msg: 'Invalid code',
                      backgroundColor: PbColors.red,
                    );
                  }
                },
              ),
              BlocListener<RegisterBloc, RegisterState>(
                listener: (context, registerSt) {
                  if (registerSt is RegisterLoaded) {
                    context.goTo(
                      page: const PassBlockFrictionlessSecurityApp(),
                    );
                  }
                },
              ),
              BlocListener<LoginBloc, LoginState>(
                listener: (context, loginSt) {
                  if (loginSt is LoginLoaded) {
                    context.goTo(
                      page: const PassBlockFrictionlessSecurityApp(),
                    );
                  }
                },
              ),
            ],
            child: Scaffold(
              appBar: AppBar(),
              body: BlocBuilder<OtpBloc, OtpState>(
                builder: (context, otpSt) {
                  return Container(
                    width: context.width,
                    padding: EdgeInsets.symmetric(
                      horizontal: sx(20),
                      vertical: sy(10),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: sy(20),
                          ),
                          Center(
                            child: Image(
                              image: const AssetImage(
                                  'assets/images/logo-text.png'),
                              height: sy(80),
                            ),
                          ),
                          SizedBox(
                            height: sy(40),
                          ),
                          Text(
                            'We’ve sent your confirmation code to your number. Enter '
                            '6-digit verification code below.',
                            style: TextStyle(
                              color: PbColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: sy(10),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: sy(50),
                          ),
                          OTPTextField(
                            length: otpLen,
                            width: context.width,
                            fieldWidth: sx(70),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: sy(8),
                            ),
                            style: TextStyle(
                              color: PbColors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: sy(12),
                            ),
                            textFieldAlignment: MainAxisAlignment.spaceEvenly,
                            fieldStyle: FieldStyle.box,
                            onChanged: (pin) {
                              log('Changed: $pin');
                              setState(() {
                                otp = pin;
                              });
                            },
                            onCompleted: (pin) {
                              log('Completed: $pin');
                              setState(() {
                                otp = pin;
                              });
                            },
                            controller: otpFieldController,
                          ),
                          SizedBox(
                            height: sy(100),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Didn't receive a code? ",
                                style: TextStyle(
                                  color: PbColors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: sy(10),
                                ),
                              ),
                              Text(
                                'Click',
                                style: TextStyle(
                                  color: PbColors.blue,
                                  fontWeight: FontWeight.w700,
                                  fontSize: sy(10),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: sy(10),
                          ),
                          PbButton(
                            isDisabled: !isFormValid(),
                            disabledBtnColor: PbColors.grey.withOpacity(0.4),
                            text: 'Verify and Continue',
                            onTap: () {
                              if (otpSt is OtpSent) {
                                otpBloc.verify(
                                  verificationId: otpSt.verificationId,
                                  code: otp,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
