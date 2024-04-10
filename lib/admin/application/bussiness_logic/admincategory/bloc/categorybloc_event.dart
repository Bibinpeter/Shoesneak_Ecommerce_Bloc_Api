part of 'categorybloc_bloc.dart';

@immutable
sealed class CategoryblocEvent {}
class LoadCategory extends CategoryblocEvent {}

class AddCategory extends CategoryblocEvent {
  final String name;
  AddCategory({required this.name});
}

class EditCategory extends CategoryblocEvent {
  final String name;
  final String newName;
  EditCategory({required this.name, required this.newName});
}

class DeleteCategory extends CategoryblocEvent {
  final int id;
  DeleteCategory({required this.id});
}