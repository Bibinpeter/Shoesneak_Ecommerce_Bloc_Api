import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shoesneak/admin/data/repository/admin_category.dart';

part 'categorybloc_event.dart';
part 'categorybloc_state.dart';

class CategoryblocBloc extends Bloc<CategoryblocEvent, CategoryblocState> {
  final AdminCategoryRepo repository = AdminCategoryRepo();
  CategoryblocBloc() : super(CategoryblocInitial()) {
    on<CategoryblocEvent>((event, emit) async {
      emit(CategoryLoading());
      try {
        final categories = await repository.getCategories();
        emit(CategoryLoaded(categories: categories));
      } catch (e) {
        emit(CategoryError(message: e.toString()));
      }
    });

    on<AddCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        await repository.addCategory(event.name);
        final categories = await repository.getCategories();
        emit(CategoryLoaded(categories: categories));
      } catch (e) {
        emit(CategoryError(message: e.toString()));
      }
    });
  }
}
