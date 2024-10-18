import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shope_ease/network/model_class/product_response.dart';
import 'package:shope_ease/network/repos/cart_repo.dart';
import 'package:shope_ease/network/repos/home_repo.dart';
import 'package:shope_ease/network/repos/wishlist_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<Product> wishlistItems = [];
  List<Product> cartItems = [];

  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialFetchEvent>(_getHomeProducts);
    on<AddRemoveFromWishlistEvent>(_addRemoveWishlist);
    on<AddRemoveCartEvent>(_addRemoveCart);
  }

  FutureOr<void> _getHomeProducts(
      HomeInitialFetchEvent event, Emitter<HomeState> emit) async {
    try {
      final products = await HomeRepo().fetchProducts();
      final sales = await HomeRepo().fetchSalesProducts();
      emit(HomeSuccessState(products: products));
    } catch (e) {
      emit(HomeErrorState(error: 'Failed to fetch products'));
    }
  }

  FutureOr<void> _addRemoveWishlist(
      AddRemoveFromWishlistEvent event, Emitter<HomeState> emit) async {
    emit(WishLoadingListState());
    try {
      final productId = event.product.id;

      if (wishlistItems.any((item) => item.id == productId)) {
        await WishlistRepo().removeProductFromWishlist(event.product);
        wishlistItems.removeWhere((item) => item.id == productId);
      } else {
        await WishlistRepo().addProductToWishlist(event.product);
        wishlistItems.add(event.product);
      }

      emit(WishSuccessListState(products: wishlistItems));
    } catch (e) {
      emit(WishSuccessListErrorState(
          message: 'Failed to add/remove item to/from wishlist: $e'));
    }
  }

  FutureOr<void> _addRemoveCart(
      AddRemoveCartEvent event, Emitter<HomeState> emit) async {
    emit(WishLoadingListState());
    try {
      final productId = event.product.id;

      if (cartItems.any((item) => item.id == productId)) {
        await CartRepo().removeFromCart(event.product);
        cartItems.removeWhere((item) => item.id == productId);
      } else {
        await CartRepo().addToCart(event.product);
        cartItems.add(event.product);
      }

      emit(CartSuccessState(products: cartItems));
    } catch (e) {
      emit(WishSuccessListErrorState(
          message: 'Failed to add/remove item to/from wishlist: $e'));
    }
  }
}
