import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesneak/bloc/auth/bloc/splashbloc_event.dart';
import 'package:shoesneak/bloc/auth/bloc/splashbloc_state.dart';
 
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitialState()) {
    on<SetSplash>((event, emit)  {
      emit(SplashLoadingState());
      emit(SplashLoadedState());
    });
  }
}  