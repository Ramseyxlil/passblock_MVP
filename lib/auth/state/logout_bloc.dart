import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../repositories/repo_auth.dart';

class LogoutBloc extends Cubit<LogoutState> {
  LogoutBloc() : super(LogoutLoading());

  final RepoAuth repo = RepoAuth();

  Future<void> fetch() async {
    await repo.logout();
    emit(LogoutLoaded());
  }
}

abstract class LogoutState {}

class LogoutLoading extends LogoutState {}

class LogoutLoaded extends LogoutState {}
