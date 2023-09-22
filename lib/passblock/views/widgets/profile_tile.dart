//
//  password_manager
//  profile_tile
//
//  Created by Ngonidzashe Mangudya on 22/08/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_extensions/handy_extensions.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../shared/configs/colors.dart';
import '../../../shared/utils/extensions.dart';
import '../../state/profile_bloc.dart';
import '../pages/profile.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profileSt) {
        return RelativeBuilder(
          builder: (context, height, width, sy, sx) {
            return GestureDetector(
              onTap: () {
                context.goTo(
                  page: BlocProvider.value(
                    value: BlocProvider.of<ProfileBloc>(context),
                    child: const ProfilePage(),
                  ),
                );
              },
              child: Row(
                children: [
                  if (profileSt is ProfileLoaded) ...[
                    Hero(
                      tag: 'profile-image',
                      child: Container(
                        height: sy(40),
                        width: sy(40),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: !profileSt.res.photo.isNull
                                ? NetworkImage(
                                    '${profileSt.res.photo}',
                                  ) as ImageProvider
                                : const AssetImage(
                                    'assets/images/memoji.png',
                                  ),
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
                            '${profileSt.res.firstName} ${profileSt.res.lastName}',
                            style: TextStyle(
                              color: PbColors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: sy(12),
                            ),
                          ),
                          Text(
                            profileSt.res.email ?? '-',
                            style: TextStyle(
                              color: PbColors.textGrey,
                              fontWeight: FontWeight.w400,
                              fontSize: sy(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: sx(10),
                    ),
                    Icon(
                      CupertinoIcons.chevron_right,
                      color: PbColors.black,
                      size: sy(15),
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }
}
