import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalily/features/settings/logic/profile_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../config/local/cache_helper.dart';
import '../../authentication/data/models/user_model.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);


  UserModel? userModel;
  void getUser() {
    emit(ProfileLoadingState());
    FirebaseFirestore.instance.collection('Users').doc(CacheHelper.getString(key: 'uId')).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      print(value.data());
      emit(ProfileSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ProfileErrorState(error.toString()));
    });
  }
}