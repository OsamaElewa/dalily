abstract class CalenderDepartmentState {}

class CalenderDepartmentLInitialState extends CalenderDepartmentState {}
class GetCalenderDepartmentLoadingState extends CalenderDepartmentState {}
class SelectMultiImageState extends CalenderDepartmentState {}

class GetCalenderDepartmentSuccessState extends CalenderDepartmentState {
  final List<Map<String, String>> calenderDepartment;
  GetCalenderDepartmentSuccessState(this.calenderDepartment);
}

class GetCalenderDepartmentFailureState extends CalenderDepartmentState {
  final String error;
  GetCalenderDepartmentFailureState(this.error);
}



class GetImageSupabaseLoadingState extends CalenderDepartmentState {}

class GetImageSupabaseSuccessState extends CalenderDepartmentState {
  final String url;
  GetImageSupabaseSuccessState(this.url);
}

class GetImageSupabaseFailureState extends CalenderDepartmentState {
  final String error;
  GetImageSupabaseFailureState(this.error);
}


class DeleteImageSupabaseLoadingState extends CalenderDepartmentState {}
class DeleteImageSupabaseSuccessState extends CalenderDepartmentState {}
class DeleteImageSupabaseFailureState extends CalenderDepartmentState {
  final String error;
  DeleteImageSupabaseFailureState(this.error);
}