import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:wasel/core/utils/constant.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> signUp({required String email, required String password}) async {
    emit(SignUpLoading());
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // حفظ حالة تسجيل الدخول في Hive
      final authBox = await Hive.openBox(ConstantVariable.authBox);
      await authBox.put(ConstantVariable.authKey, true);
      await authBox.put(ConstantVariable.userId, userCredential.user?.uid);
      // Log للتحقق
      log(
        'SignUp: Saved isLoggedIn: true, userId: ${userCredential.user?.uid}',
      );
      log('authBox after signUp: ${authBox.toMap()}');
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpFailure(error: e.toString()));
    }
  }
}
