import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:frond_end_rental/errors/unauthorize_error.dart';
import 'package:frond_end_rental/models/auth.dart';
import 'package:frond_end_rental/repositories/auth_repository.dart';
import 'package:frond_end_rental/utils/http.dart';
import 'package:frond_end_rental/utils/storage.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(SignedOut()) {
    on<CheckStatus>(_checkStatus);
    on<SignOut>(_signOut);
    on<Signin>(_signin);
    on<AuthChecking>((event, emit) {
      emit(CheckingState());
    });

    on<Authenticating>((event, emit) {
      emit(AuthLoading());
    });

    on<FailedAuth>((event, emit) {
      emit(SigninFailed(message: event.message));
    });
  }

  _signin(Signin event, Emitter<AuthState> emit) async {
    final client = getPublicHttpClient();
    final storage = await getStorage();
    Response result;

    if (event.username.isEmpty || event.password.isEmpty) {
      emit(SigninFailed(message: 'Email dan password wajib diisi!'));
      return;
    }

    if (event.password.length < 8) {
      emit(SigninFailed(message: 'Password minimal 8 kerakter!'));
      return;
    }

    try {
      result = await client.post('/auth/signin', data: event.toMap());
    } on DioException catch (_) {
      emit(SigninFailed(message: 'Username/password salah'));
      return;
    }

    storage.setString('token', result.data['data']['access_token']);
    final entity = AuthEntity.fromJson(result.data['data']);
    emit(SignedIn(entity));
  }

  _checkStatus(CheckStatus event, Emitter<AuthState> emit) async {
    try {
      final response = await AuthRepository.checkAuth();
      emit(SignedIn(response));
    } on UnauthorizeError catch (error) {
      emit(SignedOut(message: error.message));
    }
  }

  _signOut(SignOut event, Emitter<AuthState> emit) async {
    final storage = await getStorage();
    storage.remove('token');
    emit(SignedOut());
  }
}
