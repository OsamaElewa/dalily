

import '../../../authentication/data/models/user_model.dart';

abstract class UpdateUserProfileState {}

class UpdateUserProfileInitialState extends UpdateUserProfileState {}

class UpdateUserProfileLoadingState extends UpdateUserProfileState {}

class UpdateUserProfileSuccessState extends UpdateUserProfileState {}

class UpdateUserProfileFailureState extends UpdateUserProfileState {
  final String error;

  UpdateUserProfileFailureState(this.error);
}
