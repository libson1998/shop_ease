import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shope_ease/network/model_class/product_response.dart';

class HomeRepo {
  final CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection('products');
  final CollectionReference _salesCollection =
      FirebaseFirestore.instance.collection('sales');

  Future<List<Product>> fetchProducts() async {
    try {
      final QuerySnapshot querySnapshot = await _productsCollection.get();

       final List<Product> products = querySnapshot.docs
          .map((doc) => Product.fromFirestore(doc))
          .toList();

      return products;
    } catch (error) {
      print('Error fetching products: $error');
      rethrow;
    }
  }

  Future<List<QueryDocumentSnapshot>> fetchSalesProducts() async {
    try {
      final QuerySnapshot querySnapshot = await _salesCollection.get();
      final List<QueryDocumentSnapshot> sales = querySnapshot.docs;

      return sales;
    } catch (error) {
      print('Error fetching sales products: $error');
      rethrow;
    }
  }
}
