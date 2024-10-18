part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeActionState extends HomeState {}

final class HomeLoadingState extends HomeActionState {}

final class HomeSuccessState extends HomeActionState {
  final List<Product> products;

  HomeSuccessState({required this.products});
}

final class HomeErrorState extends HomeActionState {
  final String error;

  HomeErrorState({required this.error});
}

final class AddRemoveWishListState extends HomeActionState {

}

final class WishLoadingListState extends HomeActionState {}

final class WishSuccessListState extends HomeActionState {
  final List<Product> products;

  WishSuccessListState({
    required this.products,
  });
}

final class WishSuccessListErrorState extends HomeActionState {
  final String message;

  WishSuccessListErrorState({
    required this.message,
  });
}

class CartSuccessState extends HomeState {
  final List<Product> products;

  CartSuccessState({required this.products});
}

class CartErrorState extends HomeState {
  final String error;

  CartErrorState({required this.error});
}
