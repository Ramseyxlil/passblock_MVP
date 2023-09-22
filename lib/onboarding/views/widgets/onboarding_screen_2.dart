//
//  password_manager
//  onboarding_screen_2
//
//  Created by Ngonidzashe Mangudya on 22/08/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../shared/configs/colors.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image(
                image: const AssetImage(
                  'assets/icons/box.png',
                ),
                height: sy(150),
              ),
            ),
            SizedBox(
              height: sy(20),
            ),
            Text(
              'Everything in single click',
              style: TextStyle(
                color: PbColors.black,
                fontWeight: FontWeight.w700,
                fontSize: sy(15),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: sy(5),
            ),
            Text(
              'Add, genreate, store, transfer, sync, export & copy all your'
              ' passwords in single click. Use autofill for quick action '
              'without opening app.',
              style: TextStyle(
                color: PbColors.black,
                fontWeight: FontWeight.w400,
                fontSize: sy(10),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: sy(20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: sy(4),
                  width: sx(40),
                  decoration: BoxDecoration(
                    color: PbColors.grey.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(
                  width: sx(15),
                ),
                Container(
                  height: sy(4),
                  width: sx(80),
                  decoration: BoxDecoration(
                    color: PbColors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(
                  width: sx(15),
                ),
                Container(
                  height: sy(4),
                  width: sx(40),
                  decoration: BoxDecoration(
                    color: PbColors.grey.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
