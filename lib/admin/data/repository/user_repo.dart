import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shoesneak/admin/data/model/user.dart';
import 'package:shoesneak/admin/utils/functions/functions.dart';

class UsersRepository {
  Future<List<User>> fetchUsers() async {
    String baseUrl = 'http://10.0.2.2:3000/admin/users';
    try {
      final token = await getToken();
      final url = Uri.parse(baseUrl);

      final response = await http.get(
        url, 
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        print('Successfully fetched users: ${response.statusCode}');
        final data = jsonDecode(response.body);
        final userList = (data['data'] as List<dynamic>)
            .map((userData) => User.fromJson(userData))
            .toList();
        return userList;
      } else {
        throw Exception('Failed to fetch users: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching users: $error');
      rethrow;
    }
  }

  // Function to block a user
  Future<void> blockUser(int userId) async {
    try {
      final token = await getToken();
      final url =
          Uri.parse('http://10.0.2.2:3000/admin/users/block?id=$userId');
      final response = await http.put(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: jsonEncode({}), // Include any required data in the body
      );

      if (response.statusCode == 200) {
        print('Successfully blocked user: $userId');
      } else {
        throw Exception('Failed to block user: ${response.statusCode}');
      }
    } catch (error) {
      print('Error blocking user: $error');
      rethrow;
    }
  }

  // Function to unblock a user
  Future<void> unblockUser(int userId) async {
    try {
      final token = await getToken();
      final url =
          Uri.parse('http://10.0.2.2:3000/admin/users/unblock?id=$userId');
      final response = await http.put(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body:
            jsonEncode({}), // Include any required data in the body (if needed)
      );

      if (response.statusCode == 200) {
        print('Successfully unblocked user: $userId');
      } else {
        throw Exception('Failed to unblock user: ${response.statusCode}');
      }
    } catch (error) {
      print('Error unblocking user: $error');
      rethrow;
    }
  }
}