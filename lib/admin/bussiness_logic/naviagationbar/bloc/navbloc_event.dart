part of 'navbloc_bloc.dart';

@immutable
sealed class NavblocEvent {}

class HomePressed extends NavblocEvent {}

class AddProductPressed extends NavblocEvent {}

class OffersCouponsPressed extends NavblocEvent {}

class UserPressed extends NavblocEvent{}
