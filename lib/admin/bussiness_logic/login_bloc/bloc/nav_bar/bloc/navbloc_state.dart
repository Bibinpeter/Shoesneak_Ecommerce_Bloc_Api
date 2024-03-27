part of 'navbloc_bloc.dart';

@immutable
sealed class NavblocState {}

final class NavblocInitial extends NavblocState {}

final class HomeSelected extends NavblocState {}

final class AddProductSelected extends NavblocState {}

final class OffersCouponsSelected extends NavblocState {}

final class UserSelected extends NavblocState {}
