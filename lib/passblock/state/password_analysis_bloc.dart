import 'package:bloc/bloc.dart';

import '../../repositories/repo_auth.dart';
import '../../repositories/repo_passwords.dart';
import '../models/password/password_analysis.dart';

class PasswordAnalysisBloc extends Cubit<PasswordAnalysisState> {
  PasswordAnalysisBloc() : super(PasswordAnalysisLoading());

  final RepoPasswords _repoPassword = RepoPasswords();
  final RepoAuth _repoAuth = RepoAuth();

  Future<void> fetch() async {
    emit(PasswordAnalysisLoading());
    final PasswordAnalysis analysis = await _repoPassword.getAnalysis(
      userId: _repoAuth.getUid(),
    );
    final int countPasswords = analysis.risk + analysis.weak + analysis.safe;
    final int securePercentage = (analysis.safe / countPasswords * 100).round();
    analysis.securePercentage = securePercentage;

    emit(PasswordAnalysisLoaded(analysis));
  }
}

abstract class PasswordAnalysisState {}

class PasswordAnalysisLoading extends PasswordAnalysisState {}

class PasswordAnalysisLoaded extends PasswordAnalysisState {
  PasswordAnalysisLoaded(this.res);

  final PasswordAnalysis res;
}
