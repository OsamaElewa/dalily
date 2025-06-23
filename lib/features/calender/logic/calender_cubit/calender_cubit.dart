import 'package:dalily/features/calender/logic/calender_cubit/calender_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalenderCubit extends Cubit<CalenderState> {
  CalenderCubit() : super(GetCalenderLoadingState());

  static CalenderCubit get(context) => BlocProvider.of(context);

  List<Map<String, String>> calenderList = [];
  Future<void> getCalenderData() async {
    emit(GetCalenderLoadingState());

    try {
      final snapshot = await FirebaseFirestore.instance.collection('schedule').get();


      for (var doc in snapshot.docs) {
        final data = doc.data();
        final classId = doc.id;
        print('////////////////////');
        print(classId);
        print('////////////////////');
        final clas = data['class'] ?? '';

        calenderList.add({
          'class': clas,
          'classId' : classId
        });
      }

      emit(GetCalenderSuccessState(calenderList));
    } catch (e) {
      emit(GetCalenderFailureState(e.toString()));
    }
  }
}