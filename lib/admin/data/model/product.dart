class Product {
  final int id;
  final int categoryId;
  final String description;
  final String name;
  final double price;
  final int size;
  final int stock;

  Product({
    required this.id,
    required this.categoryId,
    required this.description,
    required this.name,
    required this.price,
    required this.size,
    required this.stock,
      required String category,
  });

  Map<String, dynamic> toJson() {
    return {
      "id":id,
      "category_id": categoryId,
      "description": description,
      "name": name,
      "price": price,
      "size": size,
      "stock": stock,
    };
  } 
}
class ProductFromApi {
  final int id;
  final String name;
  final String description;
  final int categoryId;
  final int size;
  final int stock;
  final double price;
  final double discountedPrice;
  final String productStatus;
  final List<String>? image; // Make the image field nullable

  ProductFromApi({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.size,
    required this.stock,
    required this.price,
    required this.discountedPrice,
    required this.productStatus,
    this.image,
  });

  factory ProductFromApi.fromJson(Map<String, dynamic> json) {
    return ProductFromApi(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      categoryId: json['category_id'] as int,
      size: json['size'] ,
      stock: json['stock'] as int,
      price: (json['price'] as num).toDouble(),
      discountedPrice: (json['discounted_price'] as num).toDouble(),
      productStatus: json['product_status'] as String,
      image: json['image'] != null? List<String>.from(json['image'] as List<dynamic>): null,
    );
  }

  Map<String, dynamic> toJson() {
    return { 
      'id': id,
      'name': name,
      'description': description,
      'category_id': categoryId,
      'size': size,
      'stock': stock,
      'price': price,
      'discounted_price': discountedPrice,
      'product_status': productStatus,
      'image': image,
    };
  }
}
