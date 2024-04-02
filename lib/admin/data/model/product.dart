 

import 'dart:io';

class Product {
  final int id;
  final int categoryId;
  final String description;
  final String name;
  final int price;
  final String size;
  final int stock;
   final File? image;


  Product({
    required this.id,
    required this.categoryId,
    required this.description,
    required this.name,
    required this.price,
    required this.size,
    required this.stock,
    this.image,
     
  });
}

class ProductFromApi {
  final int id; 
  final String categoryId;
  final String name;
  final String size;
  final int stock;
  final double price;
  final List<String> image;

  ProductFromApi({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.size,
    required this.stock,
    required this.price,
    required this.image,
  });

  factory ProductFromApi.fromJson(Map<String, dynamic> json) => ProductFromApi(
        id: json['id'],
        categoryId: json['category_id'] as String,
        name: json['product_name'] as String,
        size: json['size'] as String,
        stock: json['stock'] as int,
        price: json['price'].toDouble(), // Assuming price is a double
        image: List<String>.from(json['image']),
      );
}