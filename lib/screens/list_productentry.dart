import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suikashop/models/product_entry.dart';
import 'package:suikashop/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductEntryPage extends StatefulWidget {
  const ProductEntryPage({super.key});

  @override
  State<ProductEntryPage> createState() => _ProductEntryPageState();
}

class _ProductEntryPageState extends State<ProductEntryPage> {
  Future<List<Product>> fetchProducts(CookieRequest request) async {
    final response = await request.get('http://localhost:8000/products/json/');

    // Convert response to list of Product objects
    List<Product> listProducts = [];
    for (var d in response) {
      if (d != null) {
        listProducts.add(Product.fromJson(d));
      }
    }
    return listProducts;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      drawer: const LeftDrawer(), // You'll need to create this
      body: FutureBuilder(
        future: fetchProducts(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    'No products available.',
                    style: TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image
                      if (snapshot.data![index].imageUrl != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            snapshot.data![index].imageUrl!,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 150,
                                color: Colors.grey[200],
                                child: const Center(
                                  child: Icon(Icons.image_not_supported),
                                ),
                              );
                            },
                          ),
                        ),
                      const SizedBox(height: 12),
                      
                      // Product Name
                      Text(
                        snapshot.data![index].name,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      // Price
                      Text(
                        '\$${snapshot.data![index].price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.green[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      // Brand
                      Text(
                        'Brand: ${snapshot.data![index].brand.name}',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                      
                      // Categories
                      Wrap(
                        spacing: 4,
                        children: snapshot.data![index].categories
                            .map((category) => Chip(
                                  label: Text(
                                    category.name,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  backgroundColor: Colors.blue[100],
                                ))
                            .toList(),
                      ),
                      
                      // Stock
                      Text(
                        'In Stock: ${snapshot.data![index].stockQuantity}',
                        style: TextStyle(
                          color: snapshot.data![index].stockQuantity > 0
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      
                      // Description
                      if (snapshot.data![index].description != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          snapshot.data![index].description!,
                          style: const TextStyle(fontSize: 14),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}