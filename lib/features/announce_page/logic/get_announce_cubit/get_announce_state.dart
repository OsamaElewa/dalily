abstract class GetAnnounceState {}

class GetAnnounceInitialState extends GetAnnounceState {}

class GetAnnounceLoadingState extends GetAnnounceState{}
class GetAnnounceSuccessState extends GetAnnounceState{}
class GetAnnounceFailureState extends GetAnnounceState{
  final String error;
  GetAnnounceFailureState(this.error);
}
