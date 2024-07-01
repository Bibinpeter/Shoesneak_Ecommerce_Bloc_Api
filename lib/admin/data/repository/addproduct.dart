import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shoesneak/admin/data/model/product.dart';
import 'package:shoesneak/admin/utils/functions/functions.dart';

class ProductService {
  final Dio dio = Dio();

Future<Response<dynamic>> addProduct(Product product) async {
  final token = await getToken();
  dio.options.headers['Authorization'] = 'Bearer $token';

  try {
    // Convert product object to JSON
    String productJson = jsonEncode(product.toJson());

    // Make POST request to add product
    final response = await dio.post(
      'http://10.0.2.2:3000/admin/products',
      data: productJson,
      options: Options(
        contentType: Headers.jsonContentType,
      ),
    );

    return response;
  } on DioError catch (error) {
    throw Exception('Error adding product: ${error.message}');
  }
}

   

   Future<List<ProductFromApi>> getProducts() async {
    try {
      final dio = Dio();
      final token = await getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get('http://10.0.2.2:3000/admin/products');

      if (response.statusCode == 200) {
        print("Fetching products...");

        final responseData = response.data;
        List<dynamic> productMapList = responseData['data'];
        print('the length is ${productMapList.length}');
        List<ProductFromApi> productList = [];

        for (var productMap in productMapList) {
          final product = ProductFromApi.fromJson(productMap);
          productList.add(product);
        }
print('the length is ${productList.length}');
        return productList;
      } else {
        throw Exception('API error: ${response.data['error']}');
      }
    } on DioException catch (error) {
      throw Exception('Dio error fetching products: ${error.message}');
    } catch (error) {
      throw Exception('Unexpected error fetching products: $error');
    }
  }}
