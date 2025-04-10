import 'package:e_commerce_application_ui/features/personalization/screens/products/widgets/product_card_vertical.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../provider/product_api_provider.dart';
import '../../../home/models/product_model.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  _AllProductScreenState createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  late Future<ProductModel> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = ProductApiProvider().fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppbar(
        title: Text("Products"),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder<ProductModel>(
          future: _productsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData ||
                snapshot.data?.content == null ||
                snapshot.data!.content!.isEmpty) {
              return const Center(child: Text('No products available'));
            }

            final products = snapshot.data!.content!;

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.60,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCardVertical(
                  product: product, // Pass single product to ProductCardVertical
                );
              },
            );
          },
        ),
      ),
    );
  }
}
