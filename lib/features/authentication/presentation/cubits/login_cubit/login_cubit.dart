import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/local/cache_helper.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());



  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isShowPassword = true;

  void changePasswordVisibility() {
    isShowPassword = !isShowPassword;
    emit(LoginChangePasswordVisibilityState());
  }

  bool keepMeLoggedIn = false;
  void changeKeepMeLoggedIn({required bool value}) {
    keepMeLoggedIn = value;
    emit(LoginChangeKeepMeLoggedInState());
  }

  void userLogin(){
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text
    ).then((value) {
      print(value.user?.email);
      print(value.user?.uid);
      CacheHelper.setString(key: 'userId', value: value.user!.uid);
      emit(LoginSuccessState(
          value.user!.uid
      ));
    }).catchError((error){
      emit(LoginFailureState(
        error.toString(),
      ));
    });
  }
}
