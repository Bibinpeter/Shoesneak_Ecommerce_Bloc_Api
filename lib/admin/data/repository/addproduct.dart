import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shoesneak/admin/data/model/product.dart';
import 'package:shoesneak/admin/utils/functions/functions.dart';

class ProductService {
  final Dio dio = Dio();

  Future<Response<dynamic>> addProduct(Product product) async {
    final token = await getToken();
    dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      // Create FormData and add product details
      FormData formData = FormData.fromMap({
        "category_id": product.categoryId,
        "description": product.description,
        "name": product.name,
        "price": product.price,
        "size": product.size,
        "stock": product.stock,
      });

      // Check if product image is not null and add it to FormData
      if (product.image != null) {
        formData.files.add(MapEntry(
          'files',
          await MultipartFile.fromFile(
            File(product.image!.path) as String,
            filename: 'image.jpg',
          ),
        ));
      }

      // Make POST request to add product
      final response = await dio.post(
        'http://10.0.2.2:3000/admin/products',
        data: formData,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
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
      final response = await dio.get('http://10.0.2.2:3000/admin/products?page=1&count=1');

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        if (responseData['error'] == null) {
          final productList = responseData['data'] as List<dynamic>;
          return productList
              .map((productData) => ProductFromApi.fromJson(productData))
              .toList();
        } else {
          throw Exception('API error: ${responseData['error']}');
        }
      } else {
        throw Exception(
            'API request failed with status code: ${response.statusCode}');
      }
    } on DioException catch (error) {
      throw Exception('Error fetching products: ${error.message}');
    } catch (error) {
      throw Exception('Unexpected error: $error');
    }
  }

}