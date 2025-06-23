abstract class AnnounceState {}

class AnnounceInitialState extends AnnounceState {}

class AnnounceLoadingState extends AnnounceState{}
class AnnounceSuccessState extends AnnounceState{}
class AnnounceFailureState extends AnnounceState{
  final String error;
  AnnounceFailureState(this.error);
}
