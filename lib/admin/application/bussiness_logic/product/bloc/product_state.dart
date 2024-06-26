part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final List<ProductFromApi> products;

  ProductLoaded({required this.products});
}

final class ProductPosted extends ProductState {}


final class ProductError extends ProductState {}