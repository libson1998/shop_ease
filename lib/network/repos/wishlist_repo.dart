import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shope_ease/network/model_class/product_response.dart';

class WishlistRepo {
  final CollectionReference _productsCollection =
  FirebaseFirestore.instance.collection('products');

  Future<void> addProductToWishlist(Product product) async {
    try {
      await _productsCollection.doc(product.id).update({
        'isWishlist': true,
      });
    } catch (e) {
      throw Exception('Failed to add product to wishlist: $e');
    }
  }

  Future<void> removeProductFromWishlist(Product product) async {
    try {
      await _productsCollection.doc(product.id).update({
        'isWishlist': false,
      });
    } catch (e) {
      throw Exception('Failed to remove product from wishlist: $e');
    }
  }
}