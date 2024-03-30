import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shoesneak/data/shared/sharedpref.dart';
import 'package:shoesneak/domain/model/login_model.dart';
import 'package:shoesneak/domain/model/signup_model.dart';
 

class AuthRepository {
  static const String _baseUrl = 'http://10.0.2.2:3000';
  static const String _signupEndpoint = '/user/signup';
  static const String _loginEndpoint = '/user/userlogin';

  Future<String> signup(registerRequest  signupRequest) async {
    final url = Uri.parse('$_baseUrl$_signupEndpoint');
    final body = jsonEncode(signupRequest.toJson());

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json'
      },
      body: body,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // Handle successful signup (potentially parse response data)
      print('Signup successful!');
       Map<String, dynamic> responseData = json.decode(response.body);

      // Extract data from the response
      int statusCode = responseData['status_code'];
      String message = responseData['message'];

       
      print('Status Code: $statusCode');
      print('Message: $message');
      final token = responseData['data']['AccessToken'];
     await saveToken(token);
      print("object-------------------------------");
      return 'success';
    } else {
      print("error is---------------------${response.statusCode}");
      final data = jsonDecode(response.body);
      String errorMessage = '';
      if (data['error'] == 'user already exist, sign in') {
        errorMessage = data['error'];
      } else {
        errorMessage = data['message'];
      }
      print(errorMessage);
      print('Signup failed with status code: ${response.statusCode}');
      return errorMessage;
    }
  }

  Future<String> login(LoginRequest loginRequest) async {
    final url = Uri.parse('$_baseUrl$_loginEndpoint');
    final body = jsonEncode(loginRequest.toJson());

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json'
      },
      body: body,
    ); 

    if (response.statusCode == 201 || response.statusCode == 200) {
      // Handle successful signup (potentially parse response data)
      print('Login successful!');
       Map<String, dynamic> responseData = json.decode(response.body);

      // Extract data from the response
      int statusCode = responseData['status_code'];
      String message = responseData['message'];

      print('Status Code: $statusCode');
      print('Message: $message');
      final token = responseData['data']['AccessToken'];
     await saveToken(token);
      print("object-------------------------------");
      return 'success';
    } else {
      print("error is---------------------${response.statusCode}");
      final data = jsonDecode(response.body);
      String errorMessage = '';
      if (data['error'] == 'user already exist,in login') {
        errorMessage = data['error'];
      } else {
        errorMessage = data['message'];
      }
      print(errorMessage);
      print('Signup failed with status code: ${response.statusCode}');
      return errorMessage;
    }
  }

   

  // Future<Map<String, dynamic>> getUserProfile(String token) async {
  //   final url = Uri.parse('http://10.0.2.2:3000/user/profile/details');
  //   print('token is $token');
  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token', // Include token in Authorization header
  //   };

  //   final response = await http.get(url, headers: headers);

  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     print('Successfully fetching user profile: ${response.statusCode}');
  //     final body = jsonDecode(response.body);
  //     print('Successfully fetching user profile: ${body['message']}');
  //     Map<String, dynamic> usersMap = body["data"];

  //     print('User ID: ${usersMap['id']}');
  //     print('Name: ${usersMap['name']}');
  //     print('Email: ${usersMap['email']}');
  //     print('Phone: ${usersMap['phone']}');
  //     return usersMap; // Return user profile data as a map
  //   } else {
  //     print('Error fetching user profile: ${response.statusCode}');
  //     print(response.body); // Log the error response for debugging
  //     final data = jsonDecode(response.body);
  //     return data; // Indicate failure
  //   }
  // }
}