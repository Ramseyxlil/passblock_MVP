//
//  password_manager
//  password_tags
//
//  Created by Ngonidzashe Mangudya on 22/08/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handy_extensions/handy_extensions.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../passblock/models/data/password_type.dart';
import '../../../passblock/state/password_action_bloc.dart';
import '../../../passblock/state/password_detail_bloc.dart';
import '../../../shared/configs/colors.dart';
import '../../../shared/utils/extensions.dart';
import '../../../shared/widgets/pb_button.dart';
import 'password_creation_success.dart';

class PasswordTagsPage extends StatefulWidget {
  const PasswordTagsPage({
    required this.websiteName,
    required this.websiteUrl,
    required this.email,
    required this.password,
    required this.passwordStrength,
    this.passwordId,
    super.key,
  });

  final String websiteName;
  final String websiteUrl;
  final String email;
  final String password;
  final int passwordStrength;
  final String? passwordId;

  @override
  State<PasswordTagsPage> createState() => _PasswordTagsPageState();
}

class _PasswordTagsPageState extends State<PasswordTagsPage> {
  List<PasswordType> selectedPasswordTypes = [];

  late bool isEditMode;
  late PasswordActionBloc passwordActionBloc;
  late PasswordDetailBloc passwordDetailBloc;

  @override
  void initState() {
    isEditMode = !widget.passwordId.isNull;
    passwordDetailBloc = PasswordDetailBloc();
    passwordActionBloc = PasswordActionBloc();
    if (isEditMode) {
      passwordDetailBloc.fetch(widget.passwordId!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => passwordActionBloc),
        BlocProvider(create: (context) => passwordDetailBloc),
      ],
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Tag your password',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: sy(12),
                ),
              ),
            ),
            body: MultiBlocListener(
              listeners: [
                // listen to password detail
                BlocListener<PasswordDetailBloc, PasswordDetailState>(
                  listener: (context, passwordSt) {
                    if (passwordSt is PasswordDetailLoaded) {
                      final List<PasswordType> tmp = [];
                      passwordSt.res.tags?.forEach((el) {
                        for (final type in PasswordType.values) {
                          if (type.name == el) {
                            tmp.add(type);
                            return;
                          }
                        }
                      });
                      setState(() {
                        selectedPasswordTypes = tmp;
                      });
                    }
                  },
                ),
                // listen to password creation
                BlocListener<PasswordActionBloc, PasswordActionState>(
                  listener: (context, passwordAddSt) {
                    if (passwordAddSt is PasswordActionCreated) {
                      Fluttertoast.showToast(
                        msg: 'Success',
                        backgroundColor: PbColors.green,
                      );
                      context.goTo(
                        page: PasswordCreationSuccessPage(
                          websiteName: widget.websiteName,
                          websiteUrl: widget.websiteUrl,
                          email: widget.email,
                          password: widget.password,
                          tags: selectedPasswordTypes,
                        ),
                      );
                    }
                    if (passwordAddSt is PasswordActionUpdated) {
                      Fluttertoast.showToast(
                        msg: 'Password saved successfully',
                        backgroundColor: PbColors.green,
                      );
                      context
                        ..goBack()
                        ..goBack();
                    }
                  },
                ),
              ],
              child: Container(
                height: context.height,
                width: context.width,
                padding: EdgeInsets.symmetric(
                  horizontal: sx(20),
                  vertical: sy(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select the tags that best describes the application password you just generated.',
                      style: TextStyle(
                        color: PbColors.textGrey,
                        fontWeight: FontWeight.w400,
                        fontSize: sy(10),
                      ),
                    ),
                    SizedBox(
                      height: sy(20),
                    ),
                    Expanded(
                      child: Wrap(
                        runSpacing: sy(10),
                        spacing: sx(15),
                        children: PasswordType.values
                            .where((e) => e != PasswordType.all)
                            .map((e) {
                          return GestureDetector(
                            onTap: () {
                              if (selectedPasswordTypes.contains(e)) {
                                selectedPasswordTypes.remove(e);
                              } else {
                                selectedPasswordTypes.add(e);
                              }
                              setState(() {});
                            },
                            child: AnimatedContainer(
                              duration: 200.milliseconds,
                              padding: EdgeInsets.symmetric(
                                horizontal: sx(20),
                                vertical: sy(5),
                              ),
                              decoration: BoxDecoration(
                                color: selectedPasswordTypes.contains(e)
                                    ? PbColors.blue2
                                    : PbColors.grey1.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(20),
                                border: selectedPasswordTypes.contains(e)
                                    ? Border.all(
                                        color: PbColors.blue1,
                                      )
                                    : null,
                              ),
                              child: Text(
                                e.name,
                                style: TextStyle(
                                  color: selectedPasswordTypes.contains(e)
                                      ? PbColors.white
                                      : PbColors.black.withOpacity(0.6),
                                  fontWeight: FontWeight.w400,
                                  fontSize: sy(8),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: PbButton(
                            text: 'Skip',
                            btnColor: PbColors.black.withOpacity(0.4),
                            onTap: () {
                              context.goTo(
                                page: PasswordCreationSuccessPage(
                                  websiteName: widget.websiteName,
                                  websiteUrl: widget.websiteUrl,
                                  email: widget.email,
                                  password: widget.password,
                                  tags: const [],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: sx(20),
                        ),
                        Expanded(
                          child: PbButton(
                            text: 'Continue',
                            onTap: () {
                              if (!isEditMode) {
                                passwordActionBloc.create(
                                  appName: widget.websiteName,
                                  appUrl: widget.websiteUrl,
                                  identifier: widget.email,
                                  password: widget.password,
                                  passwordStrength: widget.passwordStrength,
                                  selectedTags: selectedPasswordTypes,
                                );
                              } else {
                                passwordActionBloc.update(
                                  id: widget.passwordId!,
                                  appName: widget.websiteName,
                                  appUrl: widget.websiteUrl,
                                  identifier: widget.email,
                                  password: widget.password,
                                  passwordStrength: widget.passwordStrength,
                                  selectedTags: selectedPasswordTypes,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
