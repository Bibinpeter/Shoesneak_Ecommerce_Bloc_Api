part of 'splash_bloc.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}
class SplashLoadingState extends SplashState {}

class SplashLoadedState extends SplashState {}