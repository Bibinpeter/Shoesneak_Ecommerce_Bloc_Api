part of 'categorybloc_bloc.dart';

@immutable
sealed class CategoryblocState {}

final class CategoryblocInitial extends CategoryblocState {}
class CategoryLoading extends CategoryblocState {}

class CategoryLoaded extends CategoryblocState {
  final List<Map<String, dynamic>> categories;
  CategoryLoaded({required this.categories});
}

class CategoryError extends CategoryblocState {
  final String message;
  CategoryError({required this.message});
}