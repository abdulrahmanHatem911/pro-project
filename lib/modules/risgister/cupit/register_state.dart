part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterError extends RegisterState {
  final String error;
  RegisterError(this.error);
}

class RegisterSuccess extends RegisterState {
  final UserCredential userCredential;

  RegisterSuccess({required this.userCredential});
}

class CreateUserSucess extends RegisterState {
  final String uId;
  CreateUserSucess(this.uId);
}

class CreateUserError extends RegisterState {
  final String error;
  CreateUserError(this.error);
}

class ChangePasswordVisibality extends RegisterState {}
