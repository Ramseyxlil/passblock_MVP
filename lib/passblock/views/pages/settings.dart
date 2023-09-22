//
//  password_manager
//  settings
//
//  Created by Ngonidzashe Mangudya on 22/08/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_extensions/handy_extensions.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../shared/configs/colors.dart';
import '../../../shared/utils/extensions.dart';
import '../../state/autofill_bloc.dart';
import '../../state/profile_bloc.dart';
import '../widgets/profile_tile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with AutomaticKeepAliveClientMixin {
  late ProfileBloc profileBloc;
  late AutofillBloc autofillBloc;

  @override
  void initState() {
    autofillBloc = BlocProvider.of<AutofillBloc>(context);
    profileBloc = ProfileBloc();
    profileBloc.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => profileBloc,
        ),
      ],
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, profileSt) {
          return RelativeBuilder(
            builder: (context, height, width, sy, sx) {
              return Container(
                height: context.height,
                width: context.width,
                padding: EdgeInsets.symmetric(
                  horizontal: sx(20),
                ),
                child: ListView(
                  children: [
                    SizedBox(
                      height: sy(20),
                    ),
                    const ProfileTile(),
                    SizedBox(
                      height: sy(15),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'Permissions',
                          style: TextStyle(
                            color: PbColors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: sy(12),
                          ),
                        ),
                        trailing: Icon(
                          CupertinoIcons.chevron_right,
                          color: PbColors.black,
                          size: sy(15),
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Security',
                        style: TextStyle(
                          color: PbColors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: sy(12),
                        ),
                      ),
                      trailing: Icon(
                        CupertinoIcons.chevron_right,
                        color: PbColors.black,
                        size: sy(15),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Notifications',
                        style: TextStyle(
                          color: PbColors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: sy(12),
                        ),
                      ),
                      trailing: Icon(
                        CupertinoIcons.chevron_right,
                        color: PbColors.black,
                        size: sy(15),
                      ),
                    ),
                    SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Sync',
                        style: TextStyle(
                          color: PbColors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: sy(12),
                        ),
                      ),
                      value: false,
                      onChanged: (value) {},
                    ),
                    BlocBuilder<AutofillBloc, AutofillState>(
                      builder: (context, autofillSt) {
                        return SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            'Autofill',
                            style: TextStyle(
                              color: PbColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: sy(12),
                            ),
                          ),
                          value: autofillSt is AutofillAvailable &&
                              autofillSt.enabled,
                          onChanged: (_) {
                            autofillBloc.enable();
                          },
                        );
                      },
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'About',
                        style: TextStyle(
                          color: PbColors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: sy(12),
                        ),
                      ),
                      trailing: Icon(
                        CupertinoIcons.chevron_right,
                        color: PbColors.black,
                        size: sy(15),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Help',
                        style: TextStyle(
                          color: PbColors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: sy(12),
                        ),
                      ),
                      trailing: Icon(
                        CupertinoIcons.chevron_right,
                        color: PbColors.black,
                        size: sy(15),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Version',
                        style: TextStyle(
                          color: PbColors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: sy(12),
                        ),
                      ),
                      trailing: Text(
                        '1.0.0',
                        style: TextStyle(
                          color: PbColors.textGrey,
                          fontWeight: FontWeight.w400,
                          fontSize: sy(12),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
