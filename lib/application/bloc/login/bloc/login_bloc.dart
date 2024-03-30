import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shoesneak/data/repository/authrepo.dart';
import 'package:shoesneak/domain/model/login_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
   
  LoginBloc() : super(LoginInitial()) {
    final AuthRepository authRepository = AuthRepository();
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final loginRequest = LoginRequest(
          email: event.email,
          password: event.password,
        );

        final response = await authRepository.login(loginRequest); // Use safe navigation operator '?.' to call login if authRepository is not null
        if (response == 'success') {
          emit(LoginSuccessful('User signed up successfully'));
        } else {
          emit(LoginError(response)); // Use default message if response is null
        }
      } catch (e) {
        emit(LoginError(e.toString()));
      }
    });
  }
}
