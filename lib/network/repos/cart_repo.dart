import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shope_ease/network/model_class/product_response.dart';

class CartRepo {
  final CollectionReference _productsCollection =
  FirebaseFirestore.instance.collection('products');

  Future<void> addToCart(Product product) async {
    try {
      await _productsCollection.doc(product.id).update({
        'cartAdded': true,
      });
    } catch (e) {
      throw Exception('Failed to add product to wishlist: $e');
    }
  }

  Future<void> removeFromCart(Product product) async {
    try {
      await _productsCollection.doc(product.id).update({
        'cartAdded': false,
      });
    } catch (e) {
      throw Exception('Failed to add product to wishlist: $e');
    }
  }


  Future<void> removeAllFromCart(List<Product> products) async {
    try {
      final batch = FirebaseFirestore.instance.batch();

      for (var product in products) {
        DocumentReference productRef = _productsCollection.doc(product.id);
        batch.update(productRef, {'cartAdded': false});
      }

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to update products: $e');
    }
  }
}
