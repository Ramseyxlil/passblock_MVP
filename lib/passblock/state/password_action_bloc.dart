import 'package:bloc/bloc.dart';

import '../../repositories/repo_auth.dart';
import '../../repositories/repo_passwords.dart';
import '../models/data/password_type.dart';
import '../models/password/password.dart';

class PasswordActionBloc extends Cubit<PasswordActionState> {
  PasswordActionBloc() : super(PasswordActionInitial());

  final RepoPasswords _repoPassword = RepoPasswords();
  final RepoAuth _repoAuth = RepoAuth();

  Future<void> create({
    required String appName,
    required String appUrl,
    required String identifier,
    required String password,
    required int passwordStrength,
    List<PasswordType> selectedTags = const [],
    String? image,
  }) async {
    emit(PasswordActionInitial());
    await _repoPassword.addPassword(
      Password(
        userId: _repoAuth.getUid(),
        appName: appName,
        appUrl: appUrl,
        identifier: identifier,
        password: password,
        passwordStrength: passwordStrength,
        tags: _getTags(selectedTags),
        image: image,
      ),
    );
    emit(PasswordActionCreated());
  }

  Future<void> update({
    required String id,
    required String appName,
    required String appUrl,
    required String identifier,
    required String password,
    required int passwordStrength,
    List<PasswordType> selectedTags = const [],
    String? image,
  }) async {
    emit(PasswordActionInitial());
    await _repoPassword.updatePassword(
      id: id,
      password: Password(
        appName: appName,
        appUrl: appUrl,
        identifier: identifier,
        password: password,
        passwordStrength: passwordStrength,
        tags: _getTags(selectedTags),
        image: image,
      ),
    );
    emit(PasswordActionUpdated());
  }

  Future<void> delete(String id) async {
    await _repoPassword.deletePassword(id);
    emit(PasswordActionDeleted());
  }

  Future<void> use(String id) async {
    await _repoPassword.usePassword(id);
  }

  List<String> _getTags(List<PasswordType> selectedTags) {
    final List<String> tags = [];
    for (final el in selectedTags) {
      tags.add(el.name);
    }
    return tags;
  }
}

abstract class PasswordActionState {}

class PasswordActionInitial extends PasswordActionState {}

class PasswordActionCreated extends PasswordActionState {}

class PasswordActionUpdated extends PasswordActionState {}

class PasswordActionDeleted extends PasswordActionState {}
