
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalily/features/authentication/data/models/user_model.dart';
import 'package:dalily/features/settings/logic/update_user_profile_cubit/update_user_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/local/cache_helper.dart';





class UpdateUserProfileCubit extends Cubit<UpdateUserProfileState> {
  UpdateUserProfileCubit() : super(UpdateUserProfileInitialState());


  TextEditingController nameController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  static UpdateUserProfileCubit get(context) => BlocProvider.of(context);

  //UserModel? userModel;
  Future<void> updateUser() async {
    emit(UpdateUserProfileLoadingState());

    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(CacheHelper.getString(key: 'uId'))
          .update({
        'userName': nameController.text,
        'userClass': classController.text,
        'userDepartment': departmentController.text,
      });

      emit(UpdateUserProfileSuccessState());
    } catch (error) {
      print(error.toString());
      emit(UpdateUserProfileFailureState(error.toString()));
    }
  }
}
