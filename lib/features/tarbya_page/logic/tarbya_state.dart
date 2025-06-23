abstract class TarbyaState {}

class GetTarbyaLoadingState extends TarbyaState {}

class GetTarbyaSuccessState extends TarbyaState {
  final List<Map<String, String>> tarbya;
  GetTarbyaSuccessState(this.tarbya);
}

class GetTarbyaFailureState extends TarbyaState {
  final String error;
  GetTarbyaFailureState(this.error);
}


class GetAmidLoadingState extends TarbyaState {}

class GetAmidSuccessState extends TarbyaState {
  final List<Map<String, String>> amid;
  GetAmidSuccessState(this.amid);
}

class GetAmidFailureState extends TarbyaState {
  final String error;
  GetAmidFailureState(this.error);
}


class GetWakilLoadingState extends TarbyaState {}

class GetWakilSuccessState extends TarbyaState {
  final List<Map<String, String>> wakil;
  GetWakilSuccessState(this.wakil);
}

class GetWakilFailureState extends TarbyaState {
  final String error;
  GetWakilFailureState(this.error);
}

class GetImageSupabaseLoadingState extends TarbyaState {}

class GetImageSupabaseSuccessState extends TarbyaState {
  final String url;
  GetImageSupabaseSuccessState(this.url);
}

class GetImageSupabaseFailureState extends TarbyaState {
  final String error;
  GetImageSupabaseFailureState(this.error);
}