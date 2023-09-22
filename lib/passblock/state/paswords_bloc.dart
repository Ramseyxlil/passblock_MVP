import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../repositories/repo_auth.dart';
import '../../repositories/repo_passwords.dart';
import '../models/password/password.dart';

class PasswordBloc extends Cubit<PasswordState> {
  PasswordBloc() : super(PasswordLoading());

  final RepoPasswords _repoPassword = RepoPasswords();
  final RepoAuth _repoAuth = RepoAuth();

  Future<void> fetch({String? tag}) async {
    emit(PasswordLoading());
    String? filterTag;
    if (tag != 'All') filterTag = tag;
    _repoPassword
        .getPasswords(userId: _repoAuth.getUid(), tag: filterTag)
        .listen((snapshot) {
      if (!isClosed) {
        emit(PasswordLoaded(snapshot));
      }
    });
  }
}

abstract class PasswordState {}

class PasswordLoading extends PasswordState {}

class PasswordLoaded extends PasswordState {
  PasswordLoaded(this.res);

  final List<Password> res;
}
