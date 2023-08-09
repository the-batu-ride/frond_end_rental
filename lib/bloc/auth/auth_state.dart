part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignedOut extends AuthState {
  final String? message;

  SignedOut({this.message});

  @override
  List<Object?> get props => [message];
}

class SignedIn extends AuthState {
  final AuthEntity authEntity;

  SignedIn(this.authEntity);

  @override
  List<Object?> get props => [authEntity];
}

class SigninFailed extends AuthState {
  final String? message;

  SigninFailed({this.message});

  @override
  List<Object?> get props => [message];
}

class CheckingState extends AuthState {}

class AuthLoading extends AuthState {}
