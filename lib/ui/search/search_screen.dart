import 'package:flutter/material.dart';
import 'package:shope_ease/network/model_class/product_response.dart';
import 'package:shope_ease/ui/details_screen/details_appbar.dart';
import 'package:shope_ease/utils/constants.dart';

class SearchScreen extends StatefulWidget {
  final List<Product> products;

  const SearchScreen({super.key, required this.products, });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product> filteredProducts = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
     filteredProducts = widget.products;
  }

  void _filterProducts(String query) {
    setState(() {
      searchQuery = query;
       filteredProducts = widget.products
          .where((product) =>
          product.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const SizedBox(),
        surfaceTintColor: Colors.white,
        toolbarHeight: 20,
      ),
      body: SafeArea(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: _filterProducts,
                decoration: InputDecoration(
                  hintText: "Search for products...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  suffixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return ListTile(
                    title: Text(product.name!),
                    subtitle: Text("${product.price}$currency "),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "/DetailsScreen",
                        arguments: [3, product],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}