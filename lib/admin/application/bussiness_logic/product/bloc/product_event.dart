part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class FetchProducts extends ProductEvent {
  
}

class PostProduct extends ProductEvent {
  final Product product;
  final File? imageFile;

  PostProduct({
    required this.product,
    this.imageFile,
    });
}

class PickImage extends ProductEvent {}