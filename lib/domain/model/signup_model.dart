// ignore: camel_case_types
class registerRequest {
  final String email;
  final String firstname;
  final String lastname;
  final String password;
  final String phonenumber;
  final String? refferalcode;

  registerRequest(
      {required this.email,
      required this.firstname,
      required this.lastname,
      required this.password,
      required this.phonenumber,
       this.refferalcode});
       Map<String, String> toJson() {
    return {
      'email': email,
      'firstname': firstname,
      'lastname':lastname,
      'password': password,
      'phone': phonenumber,
      'referral_code':refferalcode.toString(),
    };
  }
}
