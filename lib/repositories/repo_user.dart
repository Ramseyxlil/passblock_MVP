import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:handy_extensions/handy_extensions.dart';
import 'package:intl/intl.dart';

import '../passblock/models/user/user.dart' as user_model;

class RepoUser {
  final CollectionReference col =
      FirebaseFirestore.instance.collection('users');
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<user_model.User> getUser() async {
    final currentUser = await col.doc(_getUID()).get();
    return user_model.User.fromJson(
        currentUser.data()! as Map<String, dynamic>);
  }

  Future<void> updateUser(
    user_model.User user, {
    File? photo,
  }) async {
    if (!photo.isNull) {
      final String photoUrl = await uploadImg(photo!);
      user.photo = photoUrl;
    }
    await col.doc(_getUID()).update(user.toJson());
  }

  Future<String> uploadImg(File image) async {
    final String fileName = DateFormat('yyyyMMddHHmmss').format(DateTime.now());
    final ref = storage.ref('users').child('$fileName.png');
    await ref.putFile(image);

    final String url = await ref.getDownloadURL();
    return url;
  }

  String _getUID() {
    return auth.currentUser?.uid ?? '';
  }
}
