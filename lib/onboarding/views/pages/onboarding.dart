//
//  password_manager
//  onboarding
//
//  Created by Ngonidzashe Mangudya on 22/08/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../auth/views/pages/register.dart';
import '../../../passblock/views/pages/pass_block.dart';
import '../../../shared/configs/colors.dart';
import '../../../shared/utils/extensions.dart';
import '../../../shared/widgets/pb_button.dart';
import '../widgets/onboarding_screen_1.dart';
import '../widgets/onboarding_screen_2.dart';
import '../widgets/onboarding_screen_3.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController controller = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: sx(20),
                vertical: sy(10),
              ),
              height: height,
              width: width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (index != 0)
                        GestureDetector(
                          onTap: () {
                            log('onTap: index: $index');
                            controller.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          },
                          child: Icon(
                            CupertinoIcons.chevron_left,
                            color: PbColors.black,
                            size: sy(15),
                          ),
                        )
                      else
                        const SizedBox.shrink(),
                      if (index != 2)
                        GestureDetector(
                          onTap: () {
                            log('onTap: Skip');
                            context.goTo(
                              page: const PassBlockFrictionlessSecurityApp(),
                              // page: const RegisterPage(),
                            );
                          },
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              color: PbColors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: sy(10),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Expanded(
                    child: PageView(
                      controller: controller,
                      children: const [
                        OnboardingScreen1(),
                        OnboardingScreen2(),
                        OnboardingScreen3(),
                      ],
                      onPageChanged: (_) {
                        log('onPageChanged: $_');
                        setState(() {
                          index = _;
                        });
                      },
                    ),
                  ),
                  PbButton(
                    text: 'Next',
                    onTap: () {
                      log('onTap: index: $index');
                      if (index == 2) {
                        context.goTo(
                          page: const RegisterPage(),
                        );
                        return;
                      }
                      controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
