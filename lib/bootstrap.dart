import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'providers.dart';
import 'shared/di/di.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  if (Platform.isAndroid) {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    log('Setting immersive sticky mode for Android ✅');
  }

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  log('Setting preferred orientations ✅');

  await setupServices();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
    Sentry.captureException(details.exception, stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  await SentryFlutter.init(
    (options) {
      options
        ..dsn =
            'https://3f6479e9d8e7ae1c701ba793e6ca860c@o1107818.ingest.sentry.io/4505745823629312'
        ..tracesSampleRate = 1.0;
    },
    appRunner: () async => runApp(
      MultiBlocProvider(
        providers: providers,
        child: SentryScreenshotWidget(
          child: await builder(),
        ),
      ),
    ),
  );
}
