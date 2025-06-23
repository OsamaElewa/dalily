import 'package:dalily/features/teatchers/logic/teachers_cubit/teachers_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeachersCubit extends Cubit<TeachersState> {
  TeachersCubit() : super(GetTeachersInitialState());

  static TeachersCubit get(context) => BlocProvider.of(context);

  List<Map<String, String>> teachersList = [];
  Future<void> getTeachersData({required String departmentId}) async {
    emit(GetTeachersLoadingState());

    try {
      final snapshot = await FirebaseFirestore.instance.collection('departments').
      doc(departmentId).
      collection('teachers').get()
    ;


      for (var doc in snapshot.docs) {
        final data = doc.data();
        final name = data['name'] ?? '';
        final title = data['title'] ?? '';
        final specialization = data['specialization'] ?? '';

        teachersList.add({
          'name': name,
          'title': title,
          'specialization' : specialization
        });
      }

      emit(GetTeachersSuccessState(teachersList));
    } catch (e) {
      emit(GetTeachersFailureState(e.toString()));
    }
  }
}