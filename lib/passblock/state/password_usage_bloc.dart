import 'package:bloc/bloc.dart';

import '../../repositories/repo_auth.dart';
import '../../repositories/repo_passwords.dart';
import '../models/password/password.dart';

class PasswordUsageBloc extends Cubit<PasswordUsageState> {
  PasswordUsageBloc() : super(PasswordUsageLoading());

  final RepoPasswords _repoPassword = RepoPasswords();
  final RepoAuth _repoAuth = RepoAuth();

  Future<void> fetch() async {
    emit(PasswordUsageLoading());
    _repoPassword
        .getPasswordUsages(userId: _repoAuth.getUid())
        .listen((snapshot) {
      if (!isClosed) {
        emit(PasswordUsageLoaded(snapshot));
      }
    });
  }
}

abstract class PasswordUsageState {}

class PasswordUsageLoading extends PasswordUsageState {}

class PasswordUsageLoaded extends PasswordUsageState {
  PasswordUsageLoaded(this.res);

  final List<Password> res;
}
