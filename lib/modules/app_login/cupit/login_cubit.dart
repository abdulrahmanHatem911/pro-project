import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pre/shared/services/local/cahce_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  // userLogin
  void userLogin({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      CacheHelper.saveCacheData(key: 'login', value: true);
      CacheHelper.saveCacheData(key: 'uId', value: userCredential.user!.uid);
      emit(LoginSucess(userCredential.user!.uid));
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        print('userLogin -- No user found for that email.');
        emit(LoginError('No user found for that email.'));
      } else if (error.code == 'wrong-password') {
        print('userLogin -- Wrong password provided for that user');
        emit(LoginError('Wrong email / password'));
      }
    }
  }

// password text field
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibality() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibality());
  }
}
