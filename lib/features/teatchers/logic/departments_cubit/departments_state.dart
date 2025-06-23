abstract class DepartmentsState {}

class GetDepartmentsInitialState extends DepartmentsState {}
class GetDepartmentsLoadingState extends DepartmentsState {}

class GetDepartmentsSuccessState extends DepartmentsState {
  final List<Map<String, String>> departments;
  GetDepartmentsSuccessState(this.departments);
}

class GetDepartmentsFailureState extends DepartmentsState {
  final String error;
  GetDepartmentsFailureState(this.error);
}