import 'package:flutter/material.dart';
import 'package:separate_api/product.dart';
import 'package:separate_api/services.dart';

class CatalogCartAndCheckout extends ChangeNotifier {
  List<Product> products = [];
  Coupon? coupon;
  int? sum;
  String? error;

  init() async {
    await fetchProducts();
  }

  fetchProducts() async {
    var products = await Services().getProducts();
    products = products["result"];
    this.products = (products as List).map(
      (e) {
        var product = Product.fromJson(e);
        product.selected = 0;
        return product;
      },
    ).toList();
    notifyListeners();
  }

  addProduct(Product product) {
    var productInList = products.firstWhere(
      (element) => element.id == product.id,
    );
    var count = products.where((element) => element.selected == 1);
    sum = count.length;
    productInList.selected = 1;
    productInList.quantity = (productInList.quantity ?? 0) + 1;
    notifyListeners();
  }

  removeProduct(Product product) {
    product.quantity = product.quantity! - 1;
    var count = products.where((element) => element.selected == 1);
    sum = count.length;
    notifyListeners();
  }

  checkPrices() {
    for (var i = 0; i < products.length; i++) {
      products[i].selected = 0;
      products[i].quantity = 0;
    }
  }

  calculateTotal() {
    // TODO: Implementar algoritmo para calcular total
  }

  getCoupon(String code) async {
    error = null;
    var cupon = await Services().getCoupon(code);
    cupon = cupon["result"];
    if (cupon != null) {
      coupon = Coupon.fromJson(cupon);
      notifyListeners();
    } else {
      error = "El cupón no existe";
      notifyListeners();
    }
  }

  clearCart() {
    for (var i = 0; i < products.length; i++) {
      products[i].selected = 0;
      products[i].quantity = 0;
    }
    notifyListeners();
  }

  pay(BuildContext context) {
    clearCart();
    coupon = null;
    Navigator.of(context).pop();
  }
}

class Coupon {
  Coupon({
    this.id,
    this.code,
    this.description,
    this.type,
    this.payload,
  });

  int? id;
  String? code;
  String? description;
  String? type;
  Map<String, dynamic>? payload;

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json["id"],
      code: json["code"],
      description: json["description"],
      type: json["type"],
      payload: json["payload"],
    );
  }
}
