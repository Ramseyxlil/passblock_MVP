//
//  password_manager
//  password_analysis_tile
//
//  Created by Ngonidzashe Mangudya on 22/08/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../shared/configs/colors.dart';
import '../../../shared/utils/common.dart';
import '../../../shared/utils/extensions.dart';
import '../pages/password.dart';

class PasswordAnalysisTile extends StatelessWidget {
  const PasswordAnalysisTile({
    required this.id,
    required this.title,
    required this.url,
    required this.email,
    required this.password,
    required this.passwordStrength,
    required this.onBack,
    super.key,
  });

  final String id;
  final String title;
  final String url;
  final String email;
  final String password;
  final int passwordStrength;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return GestureDetector(
          onTap: () {
            context
                .goTo(
                  page: PasswordPage(id: id),
                )
                .then((_) => onBack());
          },
          child: ListTile(
            contentPadding: EdgeInsets.only(
              bottom: sy(10),
            ),
            leading: Container(
              height: sy(40),
              width: sy(40),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  // image: AssetImage(asset),
                  image: NetworkImage(
                    getFaviconUrl(url),
                  ),
                ),
              ),
            ),
            title: Text(
              title,
              style: TextStyle(
                color: PbColors.black,
                fontWeight: FontWeight.w500,
                fontSize: sy(10),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  email,
                  style: TextStyle(
                    color: PbColors.textGrey,
                    fontWeight: FontWeight.w400,
                    fontSize: sy(8),
                  ),
                ),
                SizedBox(
                  height: sy(10),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: (passwordStrength + 1) / 5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _getProgressColor(passwordStrength),
                    ),
                    backgroundColor: PbColors.grey1,
                    minHeight: sy(4),
                  ),
                ),
              ],
            ),
            trailing: Container(
              padding: EdgeInsets.symmetric(
                horizontal: sx(10),
                vertical: sy(2),
              ),
              decoration: BoxDecoration(
                color: _getProgressColor(passwordStrength).withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _getStrengthLabel(passwordStrength),
                style: TextStyle(
                  color: _getProgressColor(passwordStrength),
                  fontWeight: FontWeight.w400,
                  fontSize: sy(8),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getProgressColor(int strength) {
    switch (strength) {
      case 0:
        return PbColors.red;
      case 1:
        return PbColors.orange;
      case 2:
        return PbColors.green1;
      case 3:
        return PbColors.green1;
      default:
        return PbColors.red;
    }
  }

  String _getStrengthLabel(int strength) {
    switch (strength) {
      case 0:
        return 'Risk';
      case 1:
        return 'Weak';
      case 2:
        return 'Safe';
      case 3:
        return 'Safe';
      default:
        return 'Weak';
    }
  }
}
