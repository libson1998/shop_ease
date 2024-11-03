import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shope_ease/network/api_service.dart';
import 'package:dio/dio.dart' as dio;
import 'package:shope_ease/network/model_class/FeedsResponse.dart';
import 'dart:developer' as dev;

import 'package:shope_ease/network/model_class/NewsFeedsResponse.dart';
import 'package:shope_ease/utils/constants.dart';

class NewsFeedsRepo {
  final CollectionReference _productsCollection =
  FirebaseFirestore.instance.collection('homefeeds');
  static Future<NewsFeedsResponse> fetchNewsFeeds(
      ) async {
    NewsFeedsResponse newsFeedsResponse = NewsFeedsResponse();
    ApiService apiService = ApiService(dio.Dio());

    try {
      newsFeedsResponse = await apiService.getNewsFeeds(authToken, query);

      dev.log('response', error: jsonEncode(newsFeedsResponse));
    } catch (e) {
      dev.log('error', name: e.toString());
    }

    return newsFeedsResponse;
  }

  Future<List<Feeds>> fetchProducts() async {
    try {
      final QuerySnapshot querySnapshot = await _productsCollection.get();

      final List<Feeds> products = querySnapshot.docs
          .map((doc) => Feeds.fromFirestore(doc))
          .toList();

      return products;
    } catch (error) {
      print('Error fetching products: $error');
      rethrow;
    }
  }
}
