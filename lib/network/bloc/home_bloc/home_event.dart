part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialFetchEvent extends HomeEvent {}

class AddRemoveFromWishlistEvent extends HomeEvent {
  final Product product;

  AddRemoveFromWishlistEvent({required this.product});
}

class AddRemoveCartEvent extends HomeEvent {
  final Product product;

  AddRemoveCartEvent({required this.product});
}
