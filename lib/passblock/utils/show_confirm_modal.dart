import 'package:flutter/material.dart';
import 'package:handy_extensions/handy_extensions.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../shared/configs/colors.dart';
import '../../shared/utils/extensions.dart';
import '../../shared/widgets/pb_button.dart';

void showConfirmModal(
  BuildContext context, {
  required String title,
  required VoidCallback onYes,
  String subTitle = '',
  VoidCallback? onNo,
}) {
  showDialog<void>(
    context: context,
    barrierColor: Colors.black38,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: PbColors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        shadowColor: Colors.black87,
        child: RelativeBuilder(
          builder: (context, height, width, sy, sx) {
            return SizedBox(
              width: context.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: sx(15),
                      vertical: sy(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Text(
                            title,
                            style: TextStyle(
                              color: PbColors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: sy(12),
                            ),
                          ),
                        ),
                        if (subTitle.isNotEmpty) ...[
                          SizedBox(
                            height: sy(5),
                          ),
                          Center(
                            child: Text(
                              subTitle,
                              style: TextStyle(
                                color: PbColors.textGrey,
                                fontWeight: FontWeight.w400,
                                fontSize: sy(10),
                              ),
                            ),
                          ),
                        ],
                        SizedBox(
                          height: sy(25),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: PbButton(
                                text: 'Cancel',
                                btnColor: PbColors.black.withOpacity(0.4),
                                onTap: () {
                                  context.goBack();
                                },
                              ),
                            ),
                            SizedBox(
                              width: sx(20),
                            ),
                            Expanded(
                              child: PbButton(
                                text: 'Continue',
                                onTap: onYes,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
