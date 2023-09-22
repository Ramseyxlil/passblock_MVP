import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../repositories/repo_auth.dart';

class OtpBloc extends Cubit<OtpState> {
  OtpBloc() : super(OtpInitial());

  final RepoAuth _repo = RepoAuth();

  Future<void> send({required String phone}) async {
    await _repo.sendOTP(
      phone: phone,
      onSent: (verificationId, _) {
        emit(OtpSent(verificationId));
      },
      onSuccess: (PhoneAuthCredential credential) {},
      onError: (e) {
        print('error otp');
        print(e);
        emit(OtpFailed());
      },
      onRetrieve: (String code) {},
    );
  }

  Future<void> verify({
    required String verificationId,
    required String code,
  }) async {
    final PhoneAuthCredential credential = await _repo.verifyOTP(
      verificationId: verificationId,
      code: code,
    );
    emit(OtpVerified(credential));
  }
}

abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpFailed extends OtpState {}

class OtpSent extends OtpState {
  OtpSent(this.verificationId);

  final String verificationId;
}

class OtpReceived extends OtpState {
  OtpReceived(this.code);

  final String code;
}

class OtpVerified extends OtpState {
  OtpVerified(this.credential);

  final PhoneAuthCredential credential;
}
