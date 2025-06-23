abstract class TeachersState {}

class GetTeachersInitialState extends TeachersState {}
class GetTeachersLoadingState extends TeachersState {}

class GetTeachersSuccessState extends TeachersState {
  final List<Map<String, String>> teachers;
  GetTeachersSuccessState(this.teachers);
}

class GetTeachersFailureState extends TeachersState {
  final String error;
  GetTeachersFailureState(this.error);
}