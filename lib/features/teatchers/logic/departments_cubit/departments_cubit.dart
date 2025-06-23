import 'package:dalily/features/teatchers/logic/departments_cubit/departments_state.dart';
import 'package:dalily/features/teatchers/logic/teachers_cubit/teachers_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DepartmentsCubit extends Cubit<DepartmentsState> {
  DepartmentsCubit() : super(GetDepartmentsInitialState());

  static DepartmentsCubit get(context) => BlocProvider.of(context);


  List<Map<String, String>> departmentList = [];
  Future<void> getTDepartmentData() async {
    emit(GetDepartmentsLoadingState());

    try {
      final snapshot = await FirebaseFirestore.instance.collection('departments').get();


      for (var doc in snapshot.docs) {
        final data = doc.data();
        final department = data['department'] ?? '';
        final message = data['message'] ?? '';
        final seen = data['seen'] ?? '';
        final title = data['title'] ?? '';
        final target = data['target'] ?? '';

        departmentList.add({
          'department' : department,
          'message' : message,
          'seen' : seen,
          'title' : title,
          'target' : target,
          'departmentId' : doc.id
        });
      }

      emit(GetDepartmentsSuccessState(departmentList));
    } catch (e) {
      emit(GetDepartmentsFailureState(e.toString()));
    }
  }
}