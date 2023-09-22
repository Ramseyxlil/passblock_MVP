//
//  password_manager
//  search
//
//  Created by Ngonidzashe Mangudya on 22/08/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_extensions/handy_extensions.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../shared/configs/colors.dart';
import '../../state/password_usage_bloc.dart';
import '../../state/paswords_bloc.dart';
import '../widgets/password_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  late PasswordBloc passwordBloc;
  late PasswordUsageBloc passwordUsageBloc;

  String keyword = '';
  final searchController = TextEditingController();
  Timer? timer;

  @override
  void initState() {
    passwordBloc = PasswordBloc();
    passwordUsageBloc = PasswordUsageBloc();
    passwordBloc.fetch();
    passwordUsageBloc.fetch();
    super.initState();
  }

  void _onSearch(String val) {
    timer?.cancel();
    timer = Timer(const Duration(milliseconds: 500), () {
      setState(() => keyword = val);
    });
  }

  bool _canBeShowed(String name, String url, String identifier) {
    if (name.toLowerCase().contains(keyword.toLowerCase())) {
      return true;
    }
    if (url.toLowerCase().contains(keyword.toLowerCase())) {
      return true;
    }
    if (identifier.toLowerCase().contains(keyword.toLowerCase())) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => passwordBloc,
        ),
        BlocProvider(
          create: (context) => passwordUsageBloc,
        ),
      ],
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return SafeArea(
            child: Container(
              height: context.height,
              width: context.width,
              padding: EdgeInsets.symmetric(
                horizontal: sx(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: sy(10),
                  ),
                  Container(
                    width: context.width,
                    padding: EdgeInsets.symmetric(
                      horizontal: sx(10),
                    ),
                    decoration: BoxDecoration(
                      color: PbColors.grey1.withOpacity(0.62),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: searchController,
                      onChanged: _onSearch,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'search password ...',
                        prefixIcon: Icon(CupertinoIcons.search),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sy(10),
                  ),
                  BlocBuilder<PasswordBloc, PasswordState>(
                    builder: (context, passwordSt) {
                      if (passwordSt is PasswordLoaded) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: passwordSt.res.length,
                          itemBuilder: (context, i) {
                            final appName = passwordSt.res[i].appName ?? '';
                            final appUrl = passwordSt.res[i].appUrl ?? '';
                            final identifier =
                                passwordSt.res[i].identifier ?? '';
                            if (keyword.isNotEmpty &&
                                _canBeShowed(
                                  appName,
                                  appUrl,
                                  identifier,
                                )) {
                              return PasswordTile(
                                id: passwordSt.res[i].id ?? '',
                                title: appName,
                                url: appUrl,
                                email: identifier,
                                password: passwordSt.res[i].password ?? '',
                              );
                            }
                            return const SizedBox();
                          },
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  SizedBox(
                    height: sy(10),
                  ),
                  Text(
                    'Recently Used',
                    style: TextStyle(
                      color: PbColors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: sy(10),
                    ),
                  ),
                  SizedBox(
                    height: sy(10),
                  ),
                  Expanded(
                    child: BlocBuilder<PasswordUsageBloc, PasswordUsageState>(
                      builder: (context, usageSt) {
                        if (usageSt is PasswordUsageLoaded) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: usageSt.res.length,
                            itemBuilder: (context, i) {
                              return PasswordTile(
                                id: usageSt.res[i].id ?? '',
                                title: usageSt.res[i].appName ?? '',
                                url: usageSt.res[i].appUrl ?? '',
                                email: usageSt.res[i].identifier ?? '',
                                password: usageSt.res[i].password ?? '',
                              );
                            },
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
