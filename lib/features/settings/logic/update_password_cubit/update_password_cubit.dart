
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalily/features/authentication/data/models/user_model.dart';
import 'package:dalily/features/settings/logic/update_password_cubit/update_password_state.dart';
import 'package:dalily/features/settings/logic/update_user_profile_cubit/update_user_profile_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/local/cache_helper.dart';





class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  UpdatePasswordCubit() : super(UpdatePasswordInitialState());


  TextEditingController passwordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  static UpdatePasswordCubit get(context) => BlocProvider.of(context);

  bool isShowPassword = true;

  void changePasswordVisibility() {
    isShowPassword = !isShowPassword;
    emit(UpdatePasswordChangePasswordVisibilityState());
  }

  bool isShowOldPassword = true;

  void changeOldPasswordVisibility() {
    isShowOldPassword = !isShowOldPassword;
    emit(UpdatePasswordChangeOldPasswordVisibilityState());
  }

  Future<void> changePassword() async {
    emit(UpdatePasswordLoadingState());
    try {
      // المستخدم الحالي
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null && user.email != null) {
        // إعادة التحقق من هوية المستخدم
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: oldPasswordController.text,
        );

        await user.reauthenticateWithCredential(credential);

        // تغيير كلمة المرور
        await user.updatePassword(passwordController.text);
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(CacheHelper.getString(key: 'uId'))
            .update({
          'userPassword' : passwordController.text
        });
        emit(UpdatePasswordSuccessState());
        print('Password updated successfully');
      } else {
        print('No user is currently signed in');
      }
    } catch (e) {
      emit(UpdatePasswordFailureState(e.toString()));
      print('Failed to update password: $e');
    }
  }
}
