import 'package:bloc/bloc.dart';

import '../../repositories/repo_user.dart';
import '../models/user/user.dart';

class ProfileBloc extends Cubit<ProfileState> {
  ProfileBloc() : super(ProfileLoading());

  final RepoUser _repoUser = RepoUser();

  Future<void> fetch() async {
    final User user = await _repoUser.getUser();
    emit(ProfileLoaded(user));
  }
}

abstract class ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  ProfileLoaded(this.res);

  final User res;
}
