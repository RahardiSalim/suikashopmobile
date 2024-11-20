import 'dart:convert';

// Helper functions for list serialization
List<T> modelListFromJson<T>(String str, T Function(Map<String, dynamic>) fromJson) =>
    List<T>.from(json.decode(str).map((x) => fromJson(x)));

String modelListToJson<T>(List<T> data, Map<String, dynamic> Function(T) toJson) =>
    json.encode(List<dynamic>.from(data.map((x) => toJson(x))));

class Brand {
  String id;
  String name;
  String? description;
  String? website;

  Brand({
    required this.id,
    required this.name,
    this.description,
    this.website,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        website: json["website"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "website": website,
      };
}

class Category {
  String id;
  String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
class Product {
  String id; // Matches UUIDField in Django
  int userId;
  String name;
  double price;
  String? description;
  Brand brand; // Maps to the Brand model
  List<Category> categories; // Maps to Category model
  String sku;
  int stockQuantity;
  String? imageUrl; // Matches the Django `image` field

  Product({
    required this.id,
    required this.userId,
    required this.name,
    required this.price,
    this.description,
    required this.brand,
    required this.categories,
    required this.sku,
    required this.stockQuantity,
    this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        price: double.parse(json["price"].toString()), // Handle potential float parsing
        description: json["description"],
        brand: Brand.fromJson(json["brand"]),
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        sku: json["sku"],
        stockQuantity: json["stock_quantity"],
        imageUrl: json["image_url"], // Match JSON key in Django
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "price": price,
        "description": description,
        "brand": brand.toJson(),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "sku": sku,
        "stock_quantity": stockQuantity,
        "image_url": imageUrl,
      };
}


class Customer {
  String id;
  String firstName;
  String lastName;
  String email;
  String? phone;
  String? address;

  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    this.address,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "address": address,
      };
}

class Order {
  String id;
  Customer customer;
  DateTime orderDate;
  double totalAmount;

  Order({
    required this.id,
    required this.customer,
    required this.orderDate,
    required this.totalAmount,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        customer: Customer.fromJson(json["customer"]),
        orderDate: DateTime.parse(json["order_date"]),
        totalAmount: json["total_amount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer": customer.toJson(),
        "order_date": "${orderDate.year.toString().padLeft(4, '0')}-${orderDate.month.toString().padLeft(2, '0')}-${orderDate.day.toString().padLeft(2, '0')}",
        "total_amount": totalAmount,
      };
}

class OrderItem {
  String id;
  Order order;
  Product product;
  int quantity;
  double priceAtOrder;

  OrderItem({
    required this.id,
    required this.order,
    required this.product,
    required this.quantity,
    required this.priceAtOrder,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        order: Order.fromJson(json["order"]),
        product: Product.fromJson(json["product"]),
        quantity: json["quantity"],
        priceAtOrder: json["price_at_order"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order": order.toJson(),
        "product": product.toJson(),
        "quantity": quantity,
        "price_at_order": priceAtOrder,
      };
}

class Review {
  String id;
  Product product;
  Customer customer;
  int rating;
  String? comment;
  DateTime reviewDate;

  Review({
    required this.id,
    required this.product,
    required this.customer,
    required this.rating,
    this.comment,
    required this.reviewDate,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        product: Product.fromJson(json["product"]),
        customer: Customer.fromJson(json["customer"]),
        rating: json["rating"],
        comment: json["comment"],
        reviewDate: DateTime.parse(json["review_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product.toJson(),
        "customer": customer.toJson(),
        "rating": rating,
        "comment": comment,
        "review_date": "${reviewDate.year.toString().padLeft(4, '0')}-${reviewDate.month.toString().padLeft(2, '0')}-${reviewDate.day.toString().padLeft(2, '0')}",
      };
}