import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:wasel/core/utils/constant.dart';

part 'login_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // حفظ حالة تسجيل الدخول في Hive
      final authBox = await Hive.openBox(ConstantVariable.authBox);
      await authBox.put(ConstantVariable.authKey, true);
      await authBox.put(ConstantVariable.userId, userCredential.user?.uid);
      // Log للتحقق
      log('Login: Saved isLoggedIn: true, userId: ${userCredential.user?.uid}');
      log('authBox after login: ${authBox.toMap()}');
      emit(AuthSuccess(user: userCredential.user));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(error: e.message ?? 'Login failed'));
    } catch (e) {
      emit(AuthFailure(error: 'Unexpected error: ${e.toString()}'));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await _auth.signOut();
      final authBox = await Hive.openBox(ConstantVariable.authBox);
      await authBox.put(ConstantVariable.authKey, false);
      await authBox.delete(ConstantVariable.userId);

      log('Logout: Saved isLoggedIn: false');
      log('authBox after logout: ${authBox.toMap()}');
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(error: 'Logout failed: ${e.toString()}'));
    }
  }
}
