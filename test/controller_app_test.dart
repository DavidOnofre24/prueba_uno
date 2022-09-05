import 'package:api/data/products.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:separate_api/controllers/app_controller.dart';
import 'package:separate_api/models/product_model.dart';

void main() {
  group('Controller', () {
    final controller = CatalogCartAndCheckout();
    for (var element in productsDb.values) {
      controller.products.add(Product.fromJson(element));
    }

    test('El valor total sin productos debe ser 0', () {
      expect(controller.calculateTotal(), 0);
    });

    test('subtotal calcula la suma de cada uno de los productos', () {
      controller
        ..clearCart()
        ..addProduct(controller.products[2])
        ..addProduct(controller.products[2]);

      expect(controller.calculeSubtotal(), controller.products[2].price! * 2);
    });

    test(
        'Agrego un producto al carrito de 300 y el total me debe dar el mismo del producto + 100 del envio',
        () {
      controller
        ..clearCart()
        ..addProduct(controller.products[0]);
      expect(controller.calculateTotal(), controller.products[0].price! + 100);
    });

    test(
        'Agrego 2 productos al carrito de 300 y el total me debe dar el precio de los dos productos',
        () {
      controller
        ..clearCart()
        ..addProduct(controller.products[0])
        ..addProduct(controller.products[0]);
      expect(controller.calculateTotal(), controller.products[0].price! * 2);
    });
  });
}
