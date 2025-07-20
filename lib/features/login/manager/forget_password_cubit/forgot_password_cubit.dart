import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendPasswordResetEmail({required String email}) async {
    emit(ForgotPasswordLoading());
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      emit(ForgotPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      emit(
        ForgotPasswordFailure(error: e.message ?? 'Failed to send reset email'),
      );
    } catch (e) {
      emit(ForgotPasswordFailure(error: 'Unexpected error'));
    }
  }
}
