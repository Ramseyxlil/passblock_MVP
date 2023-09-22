//
//  password_manager
//  pass_block
//
//  Created by Ngonidzashe Mangudya on 22/08/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handy_extensions/handy_extensions.dart';

import 'onboarding/views/pages/onboarding.dart';
import 'passblock/views/pages/pass_block.dart';
import 'shared/configs/colors.dart';
import 'package:receive_intent/receive_intent.dart' as intent;

final auth = FirebaseAuth.instance;

class PassBlockApp extends StatefulWidget {
  const PassBlockApp({super.key});

  @override
  State<PassBlockApp> createState() => _PassBlockAppState();
}

class _PassBlockAppState extends State<PassBlockApp> {
  bool isIntentReceived = false;
  bool isAutofill = false;

  @override
  void initState() {
    _initReceiveIntent();
    super.initState();
  }

  Future<void> _initReceiveIntent() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final receivedIntent = await intent.ReceiveIntent.getInitialIntent();
      print('initial intent');
      print(receivedIntent);
      isIntentReceived = true;
      print('mode $receivedIntent');
      final Map<String, dynamic>? intentExtra = receivedIntent?.extra;
      if (intentExtra?['autofill_mode']?.startsWith('/autofill') == true) {
        isAutofill = true;
        // BlocProvider.of<AutofillCubit>(navContext).refresh();
      }
      print('launch autofill $isAutofill');
      setState(() {});
      // Validate receivedIntent and warn the user, if it is not correct,
      // but keep in mind it could be `null` or "empty"(`receivedIntent.isNull`).
    } on PlatformException {
      // Handle exception
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PassBlock',
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: PbColors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: PbColors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: PbColors.black,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: PbColors.white,
          elevation: 1,
          selectedItemColor: PbColors.black,
          unselectedItemColor: PbColors.black,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: !isIntentReceived
          ? const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : auth.currentUser.isNull
              ? const OnboardingPage()
              : PassBlockFrictionlessSecurityApp(isAutofill: isAutofill),
    );
  }
}
