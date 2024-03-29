import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shoesneak/data/model/signup_model.dart';
import 'package:shoesneak/data/repository/authrepo/authrepo.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    final AuthRepository authRepository = AuthRepository();
    on<SignupButtonPressed>((event, emit) async {
      emit(SignUpLoading());
      try {

        final signupRequest = registerRequest(
          email:event.email,
           firstname: event.firstname,
            lastname: event.lastname,
             password: event.password,
              phonenumber: event.phonenumber,
               refferalcode: event.refferalcode);

        final response = await authRepository.signup(signupRequest);
        print("response is${response}");
    
        if (response == 'success') {
          emit(SignUpSuccessful('User signed up successfully'));
        } else {
          emit(SignUpError(response));
        }
      } catch (e) {
        emit(SignUpError(e.toString()));
      }
    });
  }
}
