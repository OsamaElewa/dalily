import 'dart:io';

import 'package:dalily/features/calender/logic/calender_cubit/calender_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'calender_department_state.dart';

class CalenderDepartmentCubit extends Cubit<CalenderDepartmentState> {
  CalenderDepartmentCubit() : super(CalenderDepartmentLInitialState());

  static CalenderDepartmentCubit get(context) => BlocProvider.of(context);

  List<Map<String, String>> calenderDepartmentList = [];

  Future<void> getCalenderDepartment({required String classId}) async {
    emit(GetCalenderDepartmentLoadingState());

    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      calenderDepartmentList.clear(); // تفريغ القائمة قبل الإضافة

      final departmentsSnapshot = await firestore
          .collection('schedule')
          .doc(classId)
          .collection('departments')
          .get();
      for (var doc in departmentsSnapshot.docs) {
        final data = doc.data();
        final departmentId = doc.id;
        print('////////////////////');
        print(departmentId);
        print('////////////////////');
        final department = data['department'] ?? '';
        final title = data['title'] ?? '';

        calenderDepartmentList.add({
          'department': department,
          'title': title,
          'classId': classId,
          'departmentId' : departmentId
        });
      }

      emit(GetCalenderDepartmentSuccessState(calenderDepartmentList)); // لو محتاج تبعت بيانات تانية هنا ممكن
    } catch (e) {
      emit(GetCalenderDepartmentFailureState(e.toString()));
    }
  }


  File? imageFile;
  Future<File?> selectImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }
  Future uploadImage({required int classId, required int departmentId, context}) async
  {
    final selectedImage = await selectImage(); // ⬅️ استخدم await
    if (selectedImage == null) return;

    imageFile = selectedImage;

    final fileName = '$classId$departmentId';
    final path = 'uploads/$fileName';

    try {
      await Supabase.instance.client.storage
          .from('images')
          .upload(path, imageFile!);

      await getImageUrl(classId: classId, departmentId: departmentId); // ⬅️ نادِ بعدها
    } catch (e) {
     // emit(GetImageSupabaseFailureState(e.toString()));
    }
  }

  //String? url;
  Future<void> getImageUrl({required int classId, required int departmentId}) async
  {
    emit(GetImageSupabaseLoadingState());

    final fileName = '$classId$departmentId';
    final path = 'uploads/$fileName';

    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final publicUrl = Supabase.instance.client.storage
          .from('images')
          .getPublicUrl(path) + '?t=$timestamp';
      final dio = Dio();
      final response = await dio.get(publicUrl);
      if (response.statusCode == 200) {
        emit(GetImageSupabaseSuccessState(publicUrl));
      } else if (response.statusCode == 400) {
        print('Bad request (400)');
        emit(GetImageSupabaseFailureState('Bad Request (400)'));
      } else {
        print('Unexpected status: ${response.statusCode}');
        emit(GetImageSupabaseFailureState('Unexpected status: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final statusCode = e.response?.statusCode;
        print('Dio error with status: $statusCode');
        emit(GetImageSupabaseFailureState('Dio error: $statusCode'));
      } else {
        print('Dio error: ${e.message}');
        emit(GetImageSupabaseFailureState('Dio error: ${e.message}'));
      }
    } catch (e) {
      print('Unknown error: $e');
      emit(GetImageSupabaseFailureState('Unknown error: $e'));
    }
  }

  Future<void> deleteImage({required int classId, required int departmentId}) async
  {
    emit(DeleteImageSupabaseLoadingState());

    final fileName = '$classId$departmentId';
    final path = 'uploads/$fileName';

    try {
      final response = await Supabase.instance.client.storage
          .from('images')
          .remove([path]); // لازم تبعت List من المسارات

      getImageUrl(classId: classId, departmentId: departmentId);
    } catch (e) {
      emit(DeleteImageSupabaseFailureState(e.toString()));
      print('Error deleting image: $e');
    }
  }
  }





