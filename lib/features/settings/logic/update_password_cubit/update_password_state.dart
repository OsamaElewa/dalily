

import '../../../authentication/data/models/user_model.dart';

abstract class UpdatePasswordState {}

class UpdatePasswordInitialState extends UpdatePasswordState {}

class UpdatePasswordLoadingState extends UpdatePasswordState {}

class UpdatePasswordSuccessState extends UpdatePasswordState {}

class UpdatePasswordFailureState extends UpdatePasswordState {
  final String error;

  UpdatePasswordFailureState(this.error);
}

class UpdatePasswordChangePasswordVisibilityState extends UpdatePasswordState {}
class UpdatePasswordChangeOldPasswordVisibilityState extends UpdatePasswordState {}
