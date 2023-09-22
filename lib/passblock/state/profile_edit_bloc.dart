import 'dart:io';

import 'package:bloc/bloc.dart';

import '../../repositories/repo_user.dart';
import '../models/user/user.dart';

class ProfileEditBloc extends Cubit<ProfileEditState> {
  ProfileEditBloc() : super(ProfileEditLoading());
  final RepoUser _repoUser = RepoUser();

  Future<void> fetch({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    File? photo,
  }) async {
    emit(ProfileEditLoading());
    await _repoUser.updateUser(
      User(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      ),
      photo: photo,
    );
    emit(ProfileEditLoaded());
  }
}

abstract class ProfileEditState {}

class ProfileEditLoading extends ProfileEditState {}

class ProfileEditLoaded extends ProfileEditState {}
