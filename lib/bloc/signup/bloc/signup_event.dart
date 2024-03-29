part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

class SignupButtonPressed extends SignupEvent {
  final String email;
  final String firstname;
  final String lastname;
  final String password;
  final String phonenumber;
  final String refferalcode;

  SignupButtonPressed(
      {required this.email,
      required this.firstname,
      required this.lastname,
      required this.password,
      required this.phonenumber,
      required this.refferalcode});
}
