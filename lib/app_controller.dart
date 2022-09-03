import 'package:flutter/material.dart';
import 'package:separate_api/providers/services.dart';

import 'models/coupon_model.dart';
import 'models/product_model.dart';

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

  int calculeSubtotal() {
    var subtotal = 0;

    final listProduct =
        products.where((element) => element.selected == 1).toList();

    for (var product in listProduct) {
      subtotal += product.price! * product.quantity!;
    }

    return subtotal;
  }

  int calculeShippingCost() {
    if (calculeSubtotal() > 500 || sum == 0) {
      return 0;
    } else {
      return 100;
    }
  }

  int calculeDiscountCoupon() {
    final subtotal = calculeSubtotal();
    if (coupon != null) {
      if (coupon!.type == 'DISCOUNT_PERCENTAGE' &&
          subtotal > coupon!.payload!['minimum']) {
        return (-subtotal * (coupon!.payload!['value'] / 100)).toInt();
      }
      if (coupon!.type == 'DISCOUNT_FIXED' &&
          subtotal > coupon!.payload!['minimum']) {
        return -coupon!.payload!['value'];
      }
    }
    return 0;
  }

  int calculateDiscontPromo() {
    num discount = 0;
    var listRemove = <int>[];
    final listProduct =
        products.where((element) => element.selected == 1).toList();
    for (int i = 0; i < listProduct.length; i++) {
      if (listProduct[i].promotion! && listProduct[i].quantity! > 2) {
        discount += listProduct[i].price!;
      }
      for (int j = 0; j < listProduct.length; j++) {
        if (!listProduct[i].promotion! &&
            listProduct[i].match != null &&
            listProduct[i].match!.contains(listProduct[j].id) &&
            !listRemove.contains(listProduct[i].id)) {
          discount = listProduct[i].price! * 0.1 + listProduct[j].price! * 0.1;
          listRemove.add(listProduct[i].id!);
          listRemove.add(listProduct[j].id!);
        }
      }
    }
    return -discount.toInt();
  }

  int calculateTotal() =>
      calculeSubtotal() +
      calculeDiscountCoupon() +
      calculeShippingCost() +
      calculateDiscontPromo();

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
