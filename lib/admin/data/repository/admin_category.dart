import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shoesneak/admin/utils/functions/functions.dart';

class AdminCategoryRepo {
  final String baseUrl = 'http://10.0.2.2:3000/admin/category';
  final HttpClient client = HttpClient();

  Future<String> addCategory(String name) async {
    String? token = await getToken();
    print('The token is $token');
    final url = Uri.parse(baseUrl);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'category': name}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('succesfully added category:');

        return 'success';
      } else {
        print('could not added category: ${response.statusCode}');
        return 'Error adding category (Status Code: ${response.statusCode})';
      }
    } catch (e) {
      throw Exception('Failed to add category: $e');
    }
  }
   Future<List<Map<String, dynamic>>> getCategories() async {
    String? token = await getToken(); 
    final url = Uri.parse(baseUrl);
    print('The token is $token');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token', // Add space after Bearer
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Decode the JSON response as a Map (assuming it's a structured object)
        final body = jsonDecode(response.body);

        final data = body['data'];

        print('The category is fetched');
        // Extract the list of categories from the Map, assuming they're under a "data" key
        List<Map<String, dynamic>> list = [];
        for (var i = 0; i < data.length; i++) {
          final dataAtIndex = data[i];
          // final categoryname = dataAtIndex['category'];

          list.add(dataAtIndex);
        }

        return list;
      } else {
        throw Exception('Failed to get categories: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to get categories: $e');
    }
  }
}