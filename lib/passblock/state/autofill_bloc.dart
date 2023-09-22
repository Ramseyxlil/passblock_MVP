import 'package:bloc/bloc.dart';
import 'package:flutter_autofill_service/flutter_autofill_service.dart';

import '../../repositories/repo_user.dart';
import '../models/user/user.dart';

class AutofillBloc extends Cubit<AutofillState> {
  AutofillBloc() : super(AutofillInitial());

  final RepoUser _repoUser = RepoUser();

  Future<void> refresh() async {
    final bool enabled = await _autofillStatus();

    final bool autofillRequested =
        await AutofillService().fillRequestedAutomatic;
    final bool autofillForceInteractive =
        await AutofillService().fillRequestedInteractive;
    final androidMetadata = await AutofillService().autofillMetadata;

    print('androidMetadata $androidMetadata');
    final bool saveRequested = androidMetadata?.saveInfo != null;

    if (!autofillRequested && !autofillForceInteractive && !saveRequested) {
      emit(AutofillAvailable(enabled: true));
      return;
    }

    if (saveRequested) {
      emit(AutofillSaving(androidMetadata!));
      return;
    }

    emit(AutofillRequested(
      androidMetadata!,
      forceInteractive: autofillForceInteractive,
    ));
  }

  Future<void> enable() async {
    await AutofillService().requestSetAutofillService();
    final bool enabled = await _autofillStatus();
    ;
    emit(AutofillAvailable(enabled: enabled));
  }

  Future<void> autofillList(PwDataset dataset) async {
    await AutofillService().resultWithDatasets(
      [dataset],
    );
  }

  Future<void> autofill() async {}

  Future<bool> _autofillStatus() async {
    final available = await AutofillService().hasAutofillServicesSupport;
    bool enabled = false;
    if (available) {
      enabled = await AutofillService().status == AutofillServiceStatus.enabled;
    }
    return enabled;
  }
}

abstract class AutofillState {}

class AutofillInitial extends AutofillState {}

class AutofillAvailable extends AutofillState {
  AutofillAvailable({required this.enabled});

  final bool enabled;
}

class AutofillModeActive extends AutofillAvailable {
  AutofillModeActive(this.androidMetadata) : super(enabled: true);
  final AutofillMetadata androidMetadata;
}

class AutofillRequested extends AutofillModeActive {
  AutofillRequested(
    super.androidMetadata, {
    required this.forceInteractive,
  });

  final bool forceInteractive;
}

class AutofillSaving extends AutofillModeActive {
  AutofillSaving(super.androidMetadata);
}

class AutofillSaved extends AutofillModeActive {
  AutofillSaved(super.androidMetadata);
}
