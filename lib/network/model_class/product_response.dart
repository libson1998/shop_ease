import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String image;
  final String? name;
  final String? offerPrice;
  final String price;
  final String description;
  final bool isWishlist;
  final bool purchaseCompleted;
  final bool cartAdded;

  const Product({
    required this.id,
    required this.image,
    this.name,
    this.offerPrice,
    required this.price,
    required this.description,
    required this.isWishlist,
    required this.purchaseCompleted,
    required this.cartAdded,
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      image: data['image'] as String,
      name: data['name'] as String?,
      offerPrice: data['offerPrice'] as String?,
      price: data['price'] as String,
      description: data['description'] as String,
      isWishlist: data['isWishlist'] as bool,
      purchaseCompleted: data['purchaseCompleted'] as bool,
      cartAdded: data['cartAdded'] as bool,
    );
  }

  Product copyWith(
      {String? id,
      String? image,
      String? name,
      String? offerPrice,
      String? price,
      String? description,
      bool? isWishlist,
      bool? purchaseCompleted,
      bool? cartAdded}) {
    return Product(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      offerPrice: offerPrice ?? this.offerPrice,
      price: price ?? this.price,
      description: description ?? this.description,
      isWishlist: isWishlist ?? this.isWishlist,
      purchaseCompleted: purchaseCompleted ?? this.purchaseCompleted,
      cartAdded: cartAdded ?? this.cartAdded,
    );
  }
}
