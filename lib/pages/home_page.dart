import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:separate_api/controllers/app_controller.dart';

import '../models/product_model.dart';
import '../widgets/product_home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// TODO: Separar el codigo por secciones y eliminar comas innecesarias
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<Product> productos =
        Provider.of<CatalogCartAndCheckout>(context).products;
    productos = productos.where((element) => element.selected == 1).toList();
    bool showBadge = productos.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Home"),
        actions: [
          Badge(
            position: const BadgePosition(end: 3, top: 5),
            showBadge: showBadge,
            badgeContent: Text(
              productos.length.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            child: IconButton(
              onPressed: () => Navigator.of(context).pushNamed("/checkout"),
              icon: const Icon(Icons.shopping_cart),
            ),
          )
        ],
      ),
      body: const ShopSection(),
    );
  }

  // void _onItemTapped(int index) {
  //   setState(() {
  //     selectedSection = index;
  //   });
  // }
}

class ShopSection extends StatefulWidget {
  const ShopSection({Key? key}) : super(key: key);

  @override
  State<ShopSection> createState() => _ShopSectionState();
}

class _ShopSectionState extends State<ShopSection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CatalogCartAndCheckout>(
      builder: (context, catalog, child) {
        return ListView(
          padding: const EdgeInsets.all(20),
          children: catalog.products.map((e) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: ProductW(product: e),
            );
          }).toList(),
        );
      },
    );
  }
}
