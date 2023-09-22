//
//  password_manager
//  password
//
//  Created by Ngonidzashe Mangudya on 22/08/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handy_extensions/handy_extensions.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../passwords/views/pages/password_form.dart';
import '../../../shared/configs/colors.dart';
import '../../../shared/utils/common.dart';
import '../../../shared/utils/copy_to_clipboard.dart';
import '../../../shared/utils/extensions.dart';
import '../../state/password_action_bloc.dart';
import '../../state/password_detail_bloc.dart';
import '../../utils/show_confirm_modal.dart';

class PasswordPage extends StatelessWidget {
  const PasswordPage({
    required this.id,
    super.key,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    final passwordDetailBloc = PasswordDetailBloc()..fetch(id);
    final passwordActionBloc = PasswordActionBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => passwordDetailBloc,
        ),
        BlocProvider(
          create: (context) => passwordActionBloc,
        ),
      ],
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    showConfirmModal(
                      context,
                      title: 'Delete Password',
                      subTitle: 'Are you sure to delete this data?',
                      onYes: () {
                        context.goBack();
                        passwordActionBloc.delete(id);
                      },
                    );
                  },
                  icon: Icon(
                    CupertinoIcons.delete,
                    color: PbColors.red,
                    size: sy(15),
                  ),
                ),
              ],
            ),
            body: BlocListener<PasswordActionBloc, PasswordActionState>(
              listener: (context, actionSt) {
                if (actionSt is PasswordActionDeleted) {
                  context.goBack();
                  Fluttertoast.showToast(
                    msg: 'Password deleted successfully',
                    backgroundColor: PbColors.green,
                  );
                }
              },
              child: BlocBuilder<PasswordDetailBloc, PasswordDetailState>(
                builder: (context, passwordSt) {
                  return Container(
                    height: context.height,
                    width: context.width,
                    padding: EdgeInsets.symmetric(
                      horizontal: sx(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (passwordSt is PasswordDetailLoaded) ...[
                          Center(
                            child: Hero(
                              tag: 'password-header',
                              child: Container(
                                height: sy(80),
                                width: sy(80),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      getFaviconUrl(
                                        '${passwordSt.res.appUrl}',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: sy(10),
                          ),
                          Center(
                            child: Text(
                              passwordSt.res.appName ?? '-',
                              style: TextStyle(
                                color: PbColors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: sy(12),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              passwordSt.res.identifier ?? '-',
                              style: TextStyle(
                                color: PbColors.textGrey,
                                fontWeight: FontWeight.w400,
                                fontSize: sy(10),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: sy(10),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context
                                      .goTo(
                                    page: PasswordFormPage(
                                      passwordId: '${passwordSt.res.id}',
                                    ),
                                  )
                                      .then((_) {
                                    passwordDetailBloc.fetch(id);
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: sx(20),
                                    vertical: sy(5),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: PbColors.border),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    'Edit Password',
                                    style: TextStyle(
                                      color: PbColors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: sy(10),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: sx(10),
                              ),
                              GestureDetector(
                                onTap: () {
                                  passwordActionBloc.use(id);
                                  copyToClipboard('${passwordSt.res.password}');
                                },
                                child: ImageIcon(
                                  const AssetImage('assets/icons/copy.png'),
                                  color: PbColors.black,
                                  size: sy(15),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: sy(20),
                          ),
                          Text(
                            'Details',
                            style: TextStyle(
                              color: PbColors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: sy(12),
                            ),
                          ),
                          SizedBox(
                            height: sy(10),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Website URL',
                                  style: TextStyle(
                                    color: PbColors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: sy(10),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${passwordSt.res.appUrl}',
                                  style: TextStyle(
                                    color: PbColors.blue,
                                    fontWeight: FontWeight.w400,
                                    fontSize: sy(10),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: sy(10),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'User ID',
                                  style: TextStyle(
                                    color: PbColors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: sy(10),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  passwordSt.res.identifier ?? '',
                                  style: TextStyle(
                                    color: PbColors.textGrey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: sy(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: sy(10),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Password',
                                  style: TextStyle(
                                    color: PbColors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: sy(10),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      passwordSt.res.password ?? '',
                                      style: TextStyle(
                                        color: PbColors.textGrey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: sy(10),
                                      ),
                                    ),
                                    Icon(
                                      Icons.remove_red_eye,
                                      color: PbColors.black,
                                      size: sy(15),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: sy(10),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Tags',
                                  style: TextStyle(
                                    color: PbColors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: sy(10),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: sx(15),
                                        vertical: sy(5),
                                      ),
                                      decoration: BoxDecoration(
                                        color: PbColors.blue2,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        'Work',
                                        style: TextStyle(
                                          color: PbColors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: sy(8),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: sx(10),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: sx(15),
                                        vertical: sy(5),
                                      ),
                                      decoration: BoxDecoration(
                                        color: PbColors.blue2,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          color: PbColors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: sy(8),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: sx(10),
                                    ),
                                    Text(
                                      '+2 more',
                                      style: TextStyle(
                                        color: PbColors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: sy(8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: sy(20),
                          ),
                          Text(
                            'Settings',
                            style: TextStyle(
                              color: PbColors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: sy(12),
                            ),
                          ),
                          SwitchListTile.adaptive(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              'Autofill',
                              style: TextStyle(
                                color: PbColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: sy(10),
                              ),
                            ),
                            value: false,
                            onChanged: (value) {},
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
