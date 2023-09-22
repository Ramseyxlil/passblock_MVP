//
//  password_manager
//  password_creation_success
//
//  Created by Ngonidzashe Mangudya on 22/08/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

import 'package:flutter/material.dart';
import 'package:handy_extensions/handy_extensions.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../passblock/models/data/password_type.dart';
import '../../../passblock/views/pages/pass_block.dart';
import '../../../shared/configs/colors.dart';
import '../../../shared/utils/copy_to_clipboard.dart';
import '../../../shared/utils/extensions.dart';
import '../../../shared/widgets/pb_button.dart';

class PasswordCreationSuccessPage extends StatelessWidget {
  const PasswordCreationSuccessPage({
    required this.websiteName,
    required this.websiteUrl,
    required this.email,
    required this.password,
    required this.tags,
    super.key,
  });

  final String websiteName;
  final String websiteUrl;
  final String email;
  final String password;
  final List<PasswordType> tags;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Scaffold(
          appBar: AppBar(
            leading: const SizedBox.shrink(),
            title: Text(
              'Success',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: sy(12),
              ),
            ),
          ),
          body: Container(
            height: context.height,
            width: context.width,
            padding: EdgeInsets.symmetric(
              horizontal: sx(20),
              vertical: sy(20),
            ),
            child: Column(
              children: [
                Text(
                  'Congratulations your password has been successfully generated.',
                  style: TextStyle(
                    color: PbColors.textGrey,
                    fontWeight: FontWeight.w400,
                    fontSize: sy(10),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: context.width,
                        padding: EdgeInsets.symmetric(
                          horizontal: sx(20),
                          vertical: sy(10),
                        ),
                        decoration: BoxDecoration(
                          color: PbColors.grey1,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Password generated',
                              style: TextStyle(
                                color: PbColors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: sy(10),
                              ),
                            ),
                            SizedBox(
                              height: sy(10),
                            ),
                            Text(
                              password,
                              style: TextStyle(
                                color: PbColors.textGrey,
                                fontWeight: FontWeight.w400,
                                fontSize: sy(10),
                              ),
                            ),
                            SizedBox(
                              height: sy(10),
                            ),
                            GestureDetector(
                              onTap: () {
                                copyToClipboard(password);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ImageIcon(
                                    const AssetImage('assets/icons/copy.png'),
                                    color: PbColors.blue,
                                    size: sy(15),
                                  ),
                                  SizedBox(
                                    width: sx(10),
                                  ),
                                  Text(
                                    'Tap to copy',
                                    style: TextStyle(
                                      color: PbColors.blue,
                                      fontWeight: FontWeight.w700,
                                      fontSize: sy(10),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                PbButton(
                  text: 'Done',
                  onTap: () {
                    context.goToAndRemoveUntil(
                      page: const PassBlockFrictionlessSecurityApp(),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
