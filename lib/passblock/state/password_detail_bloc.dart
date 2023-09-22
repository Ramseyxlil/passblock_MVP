import 'package:bloc/bloc.dart';
import '../../repositories/repo_passwords.dart';
import '../models/password/password.dart';

class PasswordDetailBloc extends Cubit<PasswordDetailState> {
  PasswordDetailBloc() : super(PasswordDetailLoading());

  final RepoPasswords _repoPasswords = RepoPasswords();

  Future<void> fetch(String id) async {
    final Password res = await _repoPasswords.getDetail(id);
    emit(PasswordDetailLoaded(res));
  }
}

abstract class PasswordDetailState {}

class PasswordDetailLoading extends PasswordDetailState {}

class PasswordDetailLoaded extends PasswordDetailState {
  PasswordDetailLoaded(this.res);

  final Password res;
}
