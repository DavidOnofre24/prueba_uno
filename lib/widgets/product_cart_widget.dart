import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductCartW extends StatelessWidget {
  const ProductCartW({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            product.name!,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: Color(0xff2d2d2d),
            ),
          ),
        ),
        Text(
          "\$ ${product.price}",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
