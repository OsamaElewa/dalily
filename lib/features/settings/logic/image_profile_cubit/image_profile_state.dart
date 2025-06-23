abstract class ImageProfileState {}

class ImageProfileInitialState extends ImageProfileState {}

class GetImageSupabaseLoadingState extends ImageProfileState {}

class GetImageSupabaseSuccessState extends ImageProfileState {
  final String url;
  GetImageSupabaseSuccessState(this.url);
}

class GetImageSupabaseFailureState extends ImageProfileState {
  final String error;
  GetImageSupabaseFailureState(this.error);
}


class DeleteImageSupabaseLoadingState extends ImageProfileState {}
class DeleteImageSupabaseSuccessState extends ImageProfileState {}
class DeleteImageSupabaseFailureState extends ImageProfileState {
  final String error;
  DeleteImageSupabaseFailureState(this.error);
}