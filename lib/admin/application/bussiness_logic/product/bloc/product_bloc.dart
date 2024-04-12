import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shoesneak/admin/data/model/product.dart';
import 'package:shoesneak/admin/data/repository/addproduct.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductService productservice = ProductService();
  ProductBloc() : super(ProductInitial()) {
    on<PostProduct>((event, emit) async {
      emit(ProductLoading());
      try {
        final response = await productservice.addProduct(event.product);

        if (response.statusCode == 200 || response.statusCode == 201) {
          emit(ProductPosted());
        } else {
          print('the response is ${response.statusMessage}');
          emit(ProductError());
        }
      } catch (e) {
        emit(ProductError());
      }
    });

   
   on<FetchProducts>((event, emit) async {
  print('Fetching products...');
  emit(ProductLoading()); // Emit loading state before fetching
  try {
    final productsList = await productservice.getProducts(); // Fetch products from service
    print('Fetched products: $productsList');
    emit(ProductLoaded(products: productsList)); // Emit loaded state with products
    print('Emitted product loaded');
  } catch (e) {
    print('Error fetching products: $e');
    emit(ProductError()); // Emit error state if fetching fails
  }
});
  }
}