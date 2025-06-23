import 'package:dalily/features/tarbya_page/logic/tarbya_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TarbyaCubit extends Cubit<TarbyaState> {
  TarbyaCubit() : super(GetTarbyaLoadingState());

  static TarbyaCubit get(context) => BlocProvider.of(context);

  List<Map<String, String>> TarbyaList = [];
  Future<void> getTarbyaData() async {
    emit(GetTarbyaLoadingState());

    try {
      final snapshot = await FirebaseFirestore.instance.collection('college').get();


      for (var doc in snapshot.docs) {
        final data = doc.data();
        final title = data['title'] ?? '';
        final subTitle = data['subTitle'] ?? '';
        final imageName = data['imageName'] ?? '';

        TarbyaList.add({
          'title': title,
          'subTitle': subTitle,
          'imageName' : imageName
        });
      }

      emit(GetTarbyaSuccessState(TarbyaList));
    } catch (e) {
      emit(GetTarbyaFailureState(e.toString()));
    }
  }



  List<Map<String, String>> amid = [];
  Future<void> getAmidData() async {
    emit(GetAmidLoadingState());

    try {
      final snapshot = await FirebaseFirestore.instance.collection('amid').get();


      for (var doc in snapshot.docs) {
        final data = doc.data();
        final name = data['name'] ?? '';
        final title = data['title'] ?? '';

        amid.add({
          'name': name,
          'title' : title
        });
      }

      emit(GetAmidSuccessState(amid));
    } catch (e) {
      emit(GetAmidFailureState(e.toString()));
    }
  }


  List<Map<String, String>> wakil = [];
  Future<void> getWakilData() async {
    emit(GetWakilLoadingState());

    try {
      final snapshot = await FirebaseFirestore.instance.collection('wakil').get();


      for (var doc in snapshot.docs) {
        final data = doc.data();
        final name = data['name'] ?? '';
        final title = data['title'] ?? '';
        final image = data['image'] ?? '';

        wakil.add({
          'name': name,
          'title' : title,
          'image' : image
        });
      }

      emit(GetWakilSuccessState(wakil));
    } catch (e) {
      emit(GetWakilFailureState(e.toString()));
    }
  }



  Future<void> getImageUrl({required String imageName}) async
  {
    emit(GetImageSupabaseLoadingState());

    final fileName = imageName;
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
}