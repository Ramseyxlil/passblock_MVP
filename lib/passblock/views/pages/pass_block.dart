//
//  password_manager
//  pass_block
//
//  Created by Ngonidzashe Mangudya on 22/08/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_autofill_service/flutter_autofill_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_extensions/handy_extensions.dart';
import 'package:receive_intent/receive_intent.dart' as intent;
import 'package:relative_scale/relative_scale.dart';

import '../../../passwords/views/pages/password_form.dart';
import '../../../shared/configs/colors.dart';
import '../../../shared/state/navigation/navigation_bloc.dart';
import '../../../shared/utils/extensions.dart';
import '../../state/autofill_bloc.dart';
import 'analysis.dart';
import 'home.dart';
import 'search.dart';
import 'settings.dart';

class PassBlockFrictionlessSecurityApp extends StatefulWidget {
  const PassBlockFrictionlessSecurityApp({super.key, this.isAutofill = false});

  final bool isAutofill;

  @override
  State<PassBlockFrictionlessSecurityApp> createState() =>
      _PassBlockFrictionlessSecurityAppState();
}

class _PassBlockFrictionlessSecurityAppState
    extends State<PassBlockFrictionlessSecurityApp>
    with WidgetsBindingObserver {
  final PageController pageController = PageController();

  final Map<int, String> pageTitleIndexMap = {
    0: 'Password',
    1: 'Security',
    2: 'Search',
    3: 'Settings',
  };

  StreamSubscription<dynamic>? _receiveIntentSubscription;
  bool? _hasEnabledAutofillServices;
  AutofillMetadata? _autofillMetadata;
  bool? _fillRequestedAutomatic;
  bool? _fillRequestedInteractive;
  bool? _saveRequested;
  AutofillPreferences? _preferences;
  late AutofillBloc autofillBloc;

  @override
  void initState() {
    autofillBloc = BlocProvider.of<AutofillBloc>(context);
    autofillBloc.refresh();

    WidgetsBinding.instance.addObserver(this);
    _initReceiveIntentSubscription();
    super.initState();
  }

  Future<void> _initReceiveIntentSubscription() async {
    _receiveIntentSubscription = intent.ReceiveIntent.receivedIntentStream
        .listen((intent.Intent? intent) {
      print('listen to intent');
      print('Received intent: $intent');
      final mode = intent?.extra?['autofill_mode'];
      print('mode $mode');
      if (mode?.startsWith('/autofill') == true) {
        autofillBloc.refresh();
      }
    }, onError: (err) {
      print('intent error: $err');
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _updateStatus() async {
    _hasEnabledAutofillServices =
        await AutofillService().status == AutofillServiceStatus.enabled;
    _autofillMetadata = await AutofillService().autofillMetadata;
    print('meta data');
    print(_autofillMetadata);
    _saveRequested = _autofillMetadata?.saveInfo != null;
    _fillRequestedAutomatic = await AutofillService().fillRequestedAutomatic;
    print('request autofill $_fillRequestedAutomatic');
    _fillRequestedInteractive =
        await AutofillService().fillRequestedInteractive;
    print('interactive');
    print('inter $_fillRequestedInteractive');
    _preferences = await AutofillService().preferences;
    print('preferences');
    print(_preferences);
    setState(() {});
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_receiveIntentSubscription?.cancel());
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    print('lifecycle state $state');
    if (state == AppLifecycleState.resumed) {
      await _updateStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return BlocBuilder<NavigationBloc, int>(
          builder: (context, state) {
            return Scaffold(
              appBar: state != 2
                  ? AppBar(
                      leading: Center(
                        child: ImageIcon(
                          const AssetImage('assets/icons/person.png'),
                          size: sy(15),
                        ),
                      ),
                      title: Text(
                        pageTitleIndexMap[state] ?? 'Password',
                        style: TextStyle(
                          color: PbColors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: sy(12),
                        ),
                      ),
                      actions: [
                        if (state == 1)
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add_circle_outline,
                              size: sy(15),
                            ),
                          )
                        else
                          const SizedBox.shrink(),
                      ],
                    )
                  : null,
              body: SizedBox(
                height: context.height,
                width: context.width,
                child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    HomePage(),
                    AnalysisPage(),
                    SearchPage(),
                    SettingsPage(),
                  ],
                ),
              ),
              bottomNavigationBar: !widget.isAutofill
                  ? BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      currentIndex: state,
                      onTap: (index) {
                        context
                            .read<NavigationBloc>()
                            .add(NavigationAction(index));
                        pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      elevation: 1,
                      items: [
                        BottomNavigationBarItem(
                          icon: ImageIcon(
                            state == 0
                                ? const AssetImage(
                                    'assets/icons/home-filled.png')
                                : const AssetImage('assets/icons/home.png'),
                            size: sy(15),
                          ),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: ImageIcon(
                            state == 1
                                ? const AssetImage(
                                    'assets/icons/analysis-filled.png')
                                : const AssetImage('assets/icons/analysis.png'),
                            size: sy(15),
                          ),
                          label: 'Security',
                        ),
                        BottomNavigationBarItem(
                          icon: ImageIcon(
                            const AssetImage('assets/icons/search.png'),
                            size: sy(15),
                          ),
                          label: 'Search',
                        ),
                        BottomNavigationBarItem(
                          icon: ImageIcon(
                            state == 3
                                ? const AssetImage(
                                    'assets/icons/settings-filled.png')
                                : const AssetImage('assets/icons/settings.png'),
                            size: sy(15),
                          ),
                          label: 'Settings',
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              floatingActionButton: AnimatedSwitcher(
                duration: 200.milliseconds,
                child: !widget.isAutofill && state == 0
                    ? FloatingActionButton(
                        backgroundColor: PbColors.black,
                        onPressed: () {
                          context.goTo(
                            page: const PasswordFormPage(),
                          );
                        },
                        child: ImageIcon(
                          const AssetImage('assets/icons/key.png'),
                          size: sy(15),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            );
          },
        );
      },
    );
  }
}
