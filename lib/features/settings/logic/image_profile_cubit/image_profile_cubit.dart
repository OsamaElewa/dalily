import 'dart:io';

import 'package:dalily/features/settings/logic/image_profile_cubit/image_profile_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../config/local/cache_helper.dart';

class ImageProfileCubit extends Cubit<ImageProfileState> {
  ImageProfileCubit() : super(ImageProfileInitialState());

  static ImageProfileCubit get(context) => BlocProvider.of(context);

  File? imageFile;
  Future<File?> selectImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }
  Future uploadImage() async
  {
    final selectedImage = await selectImage(); // ⬅️ استخدم await
    if (selectedImage == null) return;

    imageFile = selectedImage;

    final fileName = CacheHelper.getString(key: 'uId');
    final path = 'uploads/$fileName';

    try {
      await Supabase.instance.client.storage
          .from('images')
          .upload(path, imageFile!);

      await getImageUrl(); // ⬅️ نادِ بعدها
    } catch (e) {
      // emit(GetImageSupabaseFailureState(e.toString()));
    }
  }

  //String? url;
  Future<void> getImageUrl() async
  {
    emit(GetImageSupabaseLoadingState());

    final fileName = CacheHelper.getString(key: 'uId');
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

  Future<void> deleteImage() async
  {
    emit(DeleteImageSupabaseLoadingState());

    final fileName = CacheHelper.getString(key: 'uId');
    final path = 'uploads/$fileName';

    try {
      final response = await Supabase.instance.client.storage
          .from('images')
          .remove([path]); // لازم تبعت List من المسارات

      getImageUrl();
    } catch (e) {
      emit(DeleteImageSupabaseFailureState(e.toString()));
      print('Error deleting image: $e');
    }
  }
}