import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shope_ease/network/model_class/product_response.dart';

class OrderRepo {
  final CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection('products');

  Future<void> purchaseProducts(List<Product> products) async {
    try {
      final batch = FirebaseFirestore.instance.batch();

      for (var product in products) {
        DocumentReference productRef = _productsCollection.doc(product.id);
        batch.update(productRef, {'purchaseCompleted': true});
      }

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to update products: $e');
    }
  }


}
