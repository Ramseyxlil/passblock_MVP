//
//  password_manager
//  switch_account_tile
//
//  Created by Ngonidzashe Mangudya on 22/08/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../shared/configs/colors.dart';

class SwitchAccountTile extends StatelessWidget {
  const SwitchAccountTile({
    required this.name,
    required this.email,
    super.key,
  });

  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Row(
          children: [
            Container(
              height: sy(35),
              width: sy(35),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/memoji.png',
                  ),
                ),
              ),
            ),
            SizedBox(
              width: sx(20),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: PbColors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: sy(10),
                    ),
                  ),
                  Text(
                    email,
                    style: TextStyle(
                      color: PbColors.textGrey,
                      fontWeight: FontWeight.w400,
                      fontSize: sy(8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
