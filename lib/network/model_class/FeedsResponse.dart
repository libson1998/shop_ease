import 'package:cloud_firestore/cloud_firestore.dart';

class Feeds {
  final String id;
  final String image;
  final String? name;
  final String? description;
  final String? location;

  const Feeds({
    required this.id,
    required this.image,
    this.name,
    this.description,
    required this.location
  });

  factory Feeds.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Feeds(
      id: doc.id,
      image: data['imageUrl'] as String,
      name: data['name'] as String?,
      description: data['description'] as String, location: data['location'],
    );
  }

  Feeds copyWith({
    String? id,
    String? image,
    String? name,
    String? description,
    String? location,
  }) {
    return Feeds(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      description: description ?? this.description, location: location ?? this.location,
    );
  }
}
