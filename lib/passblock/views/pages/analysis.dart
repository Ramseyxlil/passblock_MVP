//
//  password_manager
//  analysis
//
//  Created by Ngonidzashe Mangudya on 22/08/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_extensions/handy_extensions.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../shared/configs/colors.dart';
import '../../state/password_analysis_bloc.dart';
import '../../state/paswords_bloc.dart';
import '../widgets/password_analysis_tile.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage>
    with AutomaticKeepAliveClientMixin {
  late PasswordBloc passwordBloc;
  late PasswordAnalysisBloc passwordAnalysisBloc;

  @override
  void initState() {
    passwordBloc = PasswordBloc();
    passwordAnalysisBloc = PasswordAnalysisBloc();
    passwordBloc.fetch();
    passwordAnalysisBloc.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => passwordBloc),
        BlocProvider(create: (context) => passwordAnalysisBloc),
      ],
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return BlocBuilder<PasswordAnalysisBloc, PasswordAnalysisState>(
            builder: (context, analysisSt) {
              return Container(
                height: context.height,
                width: context.width,
                padding: EdgeInsets.symmetric(
                  horizontal: sx(20),
                  vertical: sy(20),
                ),
                child: Column(
                  children: [
                    if (analysisSt is PasswordAnalysisLoaded) ...[
                      SizedBox(
                        height: sy(80),
                        width: sy(80),
                        child: Stack(
                          children: [
                            SizedBox(
                              height: sy(80),
                              width: sy(80),
                              child: CircularProgressIndicator(
                                value: analysisSt.res.securePercentage / 100,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  PbColors.green1,
                                ),
                                // strokeCap: StrokeCap.round,
                                strokeWidth: sx(10),
                                semanticsLabel: 'Secured',
                                semanticsValue:
                                    '${analysisSt.res.securePercentage}% Secured',
                                backgroundColor: PbColors.grey.withOpacity(0.5),
                              ),
                            ),
                            Center(
                              child: Text(
                                '${analysisSt.res.securePercentage}%',
                                style: TextStyle(
                                  color: PbColors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: sy(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: sy(10),
                      ),
                      Text(
                        '${analysisSt.res.securePercentage}% Secured',
                        style: TextStyle(
                          color: PbColors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: sy(10),
                        ),
                      ),
                      SizedBox(
                        height: sy(30),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: sy(60),
                            width: sx(120),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: PbColors.border,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${analysisSt.res.safe}',
                                  style: TextStyle(
                                    color: PbColors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: sy(15),
                                  ),
                                ),
                                Text(
                                  'Safe',
                                  style: TextStyle(
                                    color: PbColors.green1,
                                    fontWeight: FontWeight.w700,
                                    fontSize: sy(10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: sy(60),
                            width: sx(120),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: PbColors.border,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${analysisSt.res.weak}',
                                  style: TextStyle(
                                    color: PbColors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: sy(15),
                                  ),
                                ),
                                Text(
                                  'Weak',
                                  style: TextStyle(
                                    color: PbColors.orange,
                                    fontWeight: FontWeight.w700,
                                    fontSize: sy(10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: sy(60),
                            width: sx(120),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: PbColors.border,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${analysisSt.res.risk}',
                                  style: TextStyle(
                                    color: PbColors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: sy(15),
                                  ),
                                ),
                                Text(
                                  'Risk',
                                  style: TextStyle(
                                    color: PbColors.red,
                                    fontWeight: FontWeight.w700,
                                    fontSize: sy(10),
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
                    ],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Analysis',
                          style: TextStyle(
                            color: PbColors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: sy(12),
                          ),
                        ),
                        ImageIcon(
                          const AssetImage('assets/icons/filter.png'),
                          color: PbColors.black,
                          size: sy(15),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: sy(10),
                    ),
                    Expanded(
                      child: BlocBuilder<PasswordBloc, PasswordState>(
                        builder: (context, passwordSt) {
                          if (passwordSt is PasswordLoaded) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: passwordSt.res.length,
                              itemBuilder: (context, i) {
                                return PasswordAnalysisTile(
                                  id: passwordSt.res[i].id ?? '',
                                  title: passwordSt.res[i].appName ?? '',
                                  url: passwordSt.res[i].appUrl ?? '',
                                  email: passwordSt.res[i].identifier ?? '',
                                  password: passwordSt.res[i].password ?? '',
                                  passwordStrength:
                                      passwordSt.res[i].passwordStrength ?? 0,
                                  onBack: passwordAnalysisBloc.fetch,
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
