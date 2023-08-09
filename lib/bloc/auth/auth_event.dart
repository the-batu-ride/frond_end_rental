part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class Signin extends AuthEvent {
  final String username;
  final String password;

  Signin({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];

  Map<String, dynamic> toMap() {
    return {
      'email': username,
      'password': password,
    };
  }
}

class CheckStatus extends AuthEvent {}

class SignOut extends AuthEvent {}

class AuthChecking extends AuthEvent {}

class Authenticating extends AuthEvent {}

class FailedAuth extends AuthEvent {
  final String? message;

  FailedAuth({this.message});

  @override
  List<Object?> get props => [message];
}
