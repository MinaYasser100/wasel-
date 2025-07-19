import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login method
  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthSuccess(user: userCredential.user));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(error: e.message ?? 'Login failed'));
    } catch (e) {
      emit(AuthFailure(error: 'Unexpected error: ${e.toString()}'));
    }
  }
}
