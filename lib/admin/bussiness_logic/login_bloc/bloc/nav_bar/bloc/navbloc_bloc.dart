import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navbloc_event.dart';
part 'navbloc_state.dart';

class NavblocBloc extends Bloc<NavblocEvent, NavblocState> {
  NavblocBloc() : super(NavblocInitial()) {
    on<HomePressed>((event, emit) => emit(HomeSelected()));
    on<AddProductPressed>((event, emit) => emit(AddProductSelected()));
    on<OffersCouponsPressed>((event, emit) => emit(OffersCouponsSelected()));
    on<UserPressed>((event, emit) => emit(UserSelected()));
  }
}
