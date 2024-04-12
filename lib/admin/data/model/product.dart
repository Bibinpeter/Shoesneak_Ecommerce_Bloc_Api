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
  final int categoryId;
  final String name;
  final String size;
  final int stock;
  final double price;
  
  ProductFromApi({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.size,
    required this.stock,
    required this.price,
   
  });

 factory ProductFromApi.fromJson(Map<String, dynamic> json) {
  return ProductFromApi(
    id: json['id'] as int, // Assuming 'id' is an integer
    categoryId: json['category_id'] as int, // Assuming 'category_id' is an integer
    name: json['product_name'] as String, // Assuming 'product_name' is a string
    size: json['size'] as String, // Assuming 'size' is a string
    stock: json['stock'] as int, // Assuming 'stock' is an integer
    price: json['price'] != null ? json['price'].toDouble() : 0.0, // Assuming 'price' is nullable and may be missing
    // image: List<String>.from(json['image']), // Uncomment if 'image' is a list of strings
  );
}

  toJson() {}

}