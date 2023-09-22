import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../repositories/repo_auth.dart';

class LoginBloc extends Cubit<LoginState> {
  LoginBloc() : super(LoginLoading());

  final RepoAuth repo = RepoAuth();

  Future<void> fetch({
    required PhoneAuthCredential credential,
  }) async {
    emit(LoginLoading());
    await repo.login(
      credential: credential,
    );
    emit(LoginLoaded());
  }
}

abstract class LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {}
