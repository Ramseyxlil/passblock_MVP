import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../passblock/models/user/user.dart' as user_model;

class RepoAuth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference col =
  FirebaseFirestore.instance.collection('users');

  Future<void> sendOTP({
    required String phone,
    required void Function(String, int?) onSent,
    required void Function(PhoneAuthCredential) onSuccess,
    required void Function(FirebaseAuthException) onError,
    required void Function(String) onRetrieve,
  }) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phone,
      codeSent: onSent,
      verificationCompleted: onSuccess,
      verificationFailed: onError,
      codeAutoRetrievalTimeout: onRetrieve,
    );
  }

  Future<PhoneAuthCredential> verifyOTP({
    required String verificationId,
    required String code,
  }) async {
    return PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: code,
    );
  }

  Future<void> register(user_model.User user, {
    required PhoneAuthCredential credential,
  }) async {
    // check phone number first
    final UserCredential cred = await auth.signInWithCredential(credential);
    await col.doc(cred.user?.uid).set(user.toJson());
  }

  Future<void> login({
    required PhoneAuthCredential credential,
  }) async {
    // check phone number first
    await auth.signInWithCredential(credential);
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  String getUid() {
    return auth.currentUser?.uid ?? '';
  }
}
