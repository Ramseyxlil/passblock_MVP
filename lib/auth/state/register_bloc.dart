import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../passblock/models/user/user.dart' as user_model;

import '../../repositories/repo_auth.dart';

class RegisterBloc extends Cubit<RegisterState> {
  RegisterBloc() : super(RegisterLoading());

  final RepoAuth repo = RepoAuth();

  Future<void> fetch({
    required String firstName,
    required String lastName,
    required String password,
    required String phone,
    required PhoneAuthCredential credential,
  }) async {
    emit(RegisterLoading());
    await repo.register(
      user_model.User(
        firstName: firstName,
        lastName: lastName,
        password: password,
        phone: phone,
      ),
      credential: credential,
    );
    emit(RegisterLoaded());
  }
}

abstract class RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterLoaded extends RegisterState {}
