import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../passblock/models/password/password.dart';
import '../passblock/models/password/password_analysis.dart';
import '../shared/models/data/password_strength.dart';

class RepoPasswords {
  final CollectionReference passwordRef =
      FirebaseFirestore.instance.collection('passwords');

  Stream<List<Password>> getPasswords({
    required String userId,
    String? tag,
  }) {
    return passwordRef
        .where('userId', isEqualTo: userId)
        .where('tags', arrayContains: tag)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((res) {
        final Password passwordItem = Password.fromJson(
          res.data()! as Map<String, dynamic>,
        )..id = res.id;
        return passwordItem;
      }).toList();
    });
  }

  Stream<List<Password>> getPasswordUsages({required String userId}) {
    return passwordRef
        .where('userId', isEqualTo: userId)
        .where('usedAt', isNull: false)
        .orderBy('usedAt', descending: true)
        .limit(5)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((res) {
        final Password passwordItem = Password.fromJson(
          res.data()! as Map<String, dynamic>,
        )..id = res.id;
        return passwordItem;
      }).toList();
    });
  }

  Future<Password> getDetail(String id) async {
    final password = await passwordRef.doc(id).get();
    return Password.fromJson(password.data()! as Map<String, dynamic>)
      ..id = password.id;
  }

  Future<PasswordAnalysis> getAnalysis({required String userId}) async {
    // count risk password strength
    final risk = await passwordRef
        .where('userId', isEqualTo: userId)
        .where(
          'passwordStrength',
          isEqualTo: PasswordStrength.weak.index,
        )
        .count()
        .get();
    // count weak password strength
    final weak = await passwordRef
        .where('userId', isEqualTo: userId)
        .where(
          'passwordStrength',
          isEqualTo: PasswordStrength.moderate.index,
        )
        .count()
        .get();
    // count safe password strength
    final safe = await passwordRef
        .where('userId', isEqualTo: userId)
        .where(
          'passwordStrength',
          whereIn: [
            PasswordStrength.strong.index,
            PasswordStrength.veryStrong.index,
          ],
        )
        .count()
        .get();

    return PasswordAnalysis(
      risk: risk.count,
      weak: weak.count,
      safe: safe.count,
      securePercentage: 0,
    );
  }

  Future<void> addPassword(Password password) async {
    await passwordRef.add(password.toJson());
  }

  Future<void> updatePassword({
    required String id,
    required Password password,
  }) async {
    await passwordRef.doc(id).update(password.toJson());
  }

  Future<void> deletePassword(String id) async {
    await passwordRef.doc(id).delete();
  }

  Future<void> usePassword(String id) async {
    await passwordRef.doc(id).update({'usedAt': Timestamp.now()});
  }
}
