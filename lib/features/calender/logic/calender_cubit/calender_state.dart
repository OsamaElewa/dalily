abstract class CalenderState {}

class GetCalenderLoadingState extends CalenderState {}

class GetCalenderSuccessState extends CalenderState {
  final List<Map<String, String>> calender;
  GetCalenderSuccessState(this.calender);
}

class GetCalenderFailureState extends CalenderState {
  final String error;
  GetCalenderFailureState(this.error);
}