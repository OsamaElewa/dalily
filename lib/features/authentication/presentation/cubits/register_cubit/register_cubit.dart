import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalily/core/functions/show_snack_bar.dart';
import 'package:dalily/features/authentication/presentation/cubits/register_cubit/register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/user_model.dart';


class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());


  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isShowPassword = true;
  bool emailSent = false;
  String uId = '';

  void changePasswordVisibility() {
    isShowPassword = !isShowPassword;
    emit(RegisterChangePasswordVisibilityState());
  }


  Future<void> checkIfVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    emit(CheckLoadingState());
    if (FirebaseAuth.instance.currentUser!.emailVerified) {

      userCreate(
        name: nameController.text,
        email: emailController.text,
        uId: uId,
        password: passwordController.text,
      );
    } else {
     emit(CheckErrorState());
    }
  }
  void registerData() {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
        .then((value) {
          value.user!.sendEmailVerification();
          uId = value.user!.uid;
          //showSuccessSnackBar(context: context, message: 'تم إرسال رابط التحقق إلى البريد الإلكتروني');
          emailSent = true;
      print(value.user?.email);
      print(value.user?.uid);
      emit(RegisterSuccessState());

    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String password,
    required String uId,
  }) {
    UserModel model = UserModel(
        userId: uId,
        userName: name,
        userEmail: email,
        userPassword: password,
        isAdmin: false,
        userClass: '',
        userDepartment: '',
    );

    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(RegisterCreateUserSuccessState(uId,model.isAdmin!));
    }).catchError((error) {
      emit(RegisterCreateUserErrorState(error.toString()));
    });
  }
}
