//
//  password_manager
//  home
//
//  Created by Ngonidzashe Mangudya on 22/08/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_extensions/handy_extensions.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../shared/configs/colors.dart';
import '../../models/data/password_type.dart';
import '../../state/paswords_bloc.dart';
import '../widgets/password_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  PasswordType passwordType = PasswordType.all;

  late PasswordBloc passwordBloc;

  @override
  void initState() {
    passwordBloc = PasswordBloc();
    passwordBloc.fetch();
    super.initState();
  }

  @override
  void dispose() {
    passwordBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => passwordBloc),
      ],
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return Container(
            height: context.height,
            width: context.width,
            padding: EdgeInsets.symmetric(
              horizontal: sx(20),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: sy(10),
                ),
                SizedBox(
                  height: sy(20),
                  width: context.width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: PasswordType.values.map((e) {
                      return GestureDetector(
                        onTap: () {
                          passwordBloc.fetch(tag: e.name);
                          setState(() {
                            passwordType = e;
                          });
                        },
                        child: AnimatedContainer(
                          duration: 200.milliseconds,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            horizontal: sx(20),
                          ),
                          margin: EdgeInsets.only(
                            right: sx(10),
                          ),
                          decoration: BoxDecoration(
                            color: e == passwordType
                                ? PbColors.black
                                : PbColors.grey1.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            e.name,
                            style: TextStyle(
                              color: e == passwordType
                                  ? PbColors.white
                                  : PbColors.black.withOpacity(0.6),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: sy(20),
                ),
                Expanded(
                  child: BlocConsumer<PasswordBloc, PasswordState>(
                    listener: (context, passwordSt) {
                      if (passwordSt is PasswordLoaded) {}
                    },
                    builder: (context, passwordSt) {
                      return passwordSt is PasswordLoaded
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: passwordSt.res.length,
                              itemBuilder: (context, i) {
                                return PasswordTile(
                                  id: passwordSt.res[i].id ?? '',
                                  title: passwordSt.res[i].appName ?? '',
                                  url: passwordSt.res[i].appUrl ?? '',
                                  email: passwordSt.res[i].identifier ?? '',
                                  password: passwordSt.res[i].password ?? '',
                                );
                              },
                            )
                          : const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
