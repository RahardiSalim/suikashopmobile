import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'dart:convert';
import 'package:suikashop/screens/list_productentry.dart';

class ProductEntryForm extends StatefulWidget {
  const ProductEntryForm({super.key});

  @override
  State<ProductEntryForm> createState() => _ProductEntryFormState();
}

class _ProductEntryFormState extends State<ProductEntryForm> {
  final _formKey = GlobalKey<FormState>();
  
  // Form fields
  String _name = "";
  double _price = 0.0;
  String _description = "";
  String _sku = "";
  int _stockQuantity = 0;
  String _imageUrl = "";
  
  // Brand fields
  String _brandName = "";
  String _brandDescription = "";
  String _brandWebsite = "";
  
  // Category field (simplified for demo - you might want to make this more dynamic)
  String _categoryName = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Product Name",
                  border: OutlineInputBorder(),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _name = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Name cannot be empty!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Price",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (String? value) {
                  setState(() {
                    _price = double.tryParse(value!) ?? 0.0;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Price cannot be empty!";
                  }
                  if (double.tryParse(value) == null) {
                    return "Price must be a number!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onChanged: (String? value) {
                  setState(() {
                    _description = value!;
                  });
                },
              ),
              const SizedBox(height: 12),
              
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "SKU",
                  border: OutlineInputBorder(),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _sku = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "SKU cannot be empty!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Stock Quantity",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (String? value) {
                  setState(() {
                    _stockQuantity = int.tryParse(value!) ?? 0;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Stock quantity cannot be empty!";
                  }
                  if (int.tryParse(value) == null) {
                    return "Stock quantity must be a number!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Image URL",
                  border: OutlineInputBorder(),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _imageUrl = value!;
                  });
                },
              ),
              const SizedBox(height: 12),
              
              // Brand Section
              const Text(
                "Brand Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Brand Name",
                  border: OutlineInputBorder(),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _brandName = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Brand name cannot be empty!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Brand Description",
                  border: OutlineInputBorder(),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _brandDescription = value!;
                  });
                },
              ),
              const SizedBox(height: 12),
              
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Brand Website",
                  border: OutlineInputBorder(),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _brandWebsite = value!;
                  });
                },
              ),
              const SizedBox(height: 12),
              
              // Category Section
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Category Name",
                  border: OutlineInputBorder(),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _categoryName = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Category name cannot be empty!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Generate unique IDs (you might want to handle this differently)
                      String productId = DateTime.now().millisecondsSinceEpoch.toString();
                      String brandId = "brand_$productId";
                      String categoryId = "category_$productId";

                      // Create the full product data
                      final response = await request.postJson(
                        "http://localhost:8000/create-product-flutter/", // Update with your URL
                        jsonEncode({
                          "id": productId,
                          "name": _name,
                          "price": _price,
                          "description": _description,
                          "brand": {
                            "id": brandId,
                            "name": _brandName,
                            "description": _brandDescription,
                            "website": _brandWebsite,
                          },
                          "categories": [
                            {
                              "id": categoryId,
                              "name": _categoryName,
                            }
                          ],
                          "sku": _sku,
                          "stock_quantity": _stockQuantity,
                          "image_url": _imageUrl,
                        }),
                      );

                      if (context.mounted) {
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Product successfully added!"),
                            ),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const ProductEntryPage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Error adding product. Please try again."),
                            ),
                          );
                        }
                      }
                    }
                  },
                  child: const Text("Add Product"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}