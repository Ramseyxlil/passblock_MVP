import 'package:flutter/material.dart';
import 'package:handy_extensions/handy_extensions.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../shared/configs/colors.dart';
import '../views/widgets/add_account_tile.dart';
import '../views/widgets/switch_account_tile.dart';

Future<void> showIOSAccountsModal(BuildContext context) async {
  await showCupertinoModalBottomSheet<void>(
    context: context,
    barrierColor: Colors.black.withOpacity(0.9),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (context) {
      return RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return Material(
            child: Container(
              height: sy(200),
              width: context.width,
              padding: EdgeInsets.symmetric(
                horizontal: sx(20),
                vertical: sy(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Switch Account',
                    style: TextStyle(
                      color: PbColors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: sy(10),
                    ),
                  ),
                  const Divider(
                    color: PbColors.border,
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        const SwitchAccountTile(
                          name: 'Steve Smith',
                          email: 'doe.steve@gmail.com',
                        ),
                        SizedBox(
                          height: sy(10),
                        ),
                        const SwitchAccountTile(
                          name: 'Ngoni Mangudya',
                          email: 'ngoni@gmail.com',
                        ),
                        SizedBox(
                          height: sy(10),
                        ),
                        const SwitchAccountTile(
                          name: 'John Smith',
                          email: 'john.s@gmail.com',
                        ),
                        SizedBox(
                          height: sy(10),
                        ),
                        const AddAccountTile(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Future<void> showAndroidAccountsModal(BuildContext context) async {
  await showMaterialModalBottomSheet<void>(
    context: context,
    builder: (context) {
      return Container();
    },
  );
}
