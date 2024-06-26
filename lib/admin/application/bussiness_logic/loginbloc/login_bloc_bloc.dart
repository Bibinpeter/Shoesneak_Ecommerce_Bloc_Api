import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'login_bloc_event.dart';
part 'login_bloc_state.dart';

class LoginBlocBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  final http.Client httpClient;

  LoginBlocBloc(this.httpClient) : super(LoginBlocInitial()) {
    on<AdminLoginButtonPressed>((event, emit) async {
      emit(LoginBlocLoading());
      try {
        print('the email is ${event.email}');
        print('the password is ${event.password}');

        final response = await httpClient.post(
          Uri.parse('http://10.0.2.2:3000/admin/adminlogin'),
          body: jsonEncode({
            'email': event.email,
            'password': event.password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final responseJson = jsonDecode(response.body);
          final accessToken = responseJson['data']['Token'];
           print('successfull---------------------');
          // Save access token using SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('accessToken', accessToken);

          emit(LoginBlocSuccess()); 
          // Emit with token
        } else {
          final errorJson = jsonDecode(response.body);
          final errorMessage = errorJson['message'] ?? 'Unknown error occurred';
          print('error is${response.statusCode}');
          emit(LoginBlocError(errorMessage));
          print("erorr------------------------------///////");
        }
      } catch (e) {
        emit(LoginBlocError('An error occurred: $e'));
      }
    });
  }
}