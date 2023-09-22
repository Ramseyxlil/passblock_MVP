//
//  password_manager
//  add_account_tile
//
//  Created by Ngonidzashe Mangudya on 22/08/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../shared/configs/colors.dart';

class AddAccountTile extends StatelessWidget {
  const AddAccountTile({super.key});

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
                color: PbColors.black,
              ),
              child: Icon(
                Icons.add,
                color: PbColors.white,
                size: sy(20),
              ),
            ),
            SizedBox(
              width: sx(20),
            ),
            Expanded(
              child: Text(
                'Add account',
                style: TextStyle(
                  color: PbColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: sy(10),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
