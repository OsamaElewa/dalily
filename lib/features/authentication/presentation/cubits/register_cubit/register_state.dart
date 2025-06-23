abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterCreateUserSuccessState extends RegisterState{
  final String uId;
  final bool isAdmin;
  RegisterCreateUserSuccessState(this.uId, this.isAdmin);
}
class RegisterCreateUserErrorState extends RegisterState{
  final String error;
  RegisterCreateUserErrorState(this.error);
}

class RegisterLoadingState extends RegisterState{}
class RegisterSuccessState extends RegisterState{}
class RegisterErrorState extends RegisterState{
  final String error;
  RegisterErrorState(this.error);
}

class CheckErrorState extends RegisterState{}
class CheckLoadingState extends RegisterState{}

class RegisterChangePasswordVisibilityState extends RegisterState {}

class RegisterChangeConfirmPasswordVisibilityState extends RegisterState {}

class RegisterChangeGenderState extends RegisterState {}
