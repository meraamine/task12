import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify_app/models/product.model.dart';
import 'package:shopify_app/providers/cart.provider.dart';
import 'package:shopify_app/widgets/selected_color.dart';
import 'package:shopify_app/widgets/selected_size.widget.dart';

class Variants_Product extends StatefulWidget {
  final Product product;
  const Variants_Product({super.key, required this.product});

  @override
  State<Variants_Product> createState() => _Variants_ProductState();
}

class _Variants_ProductState extends State<Variants_Product> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...(widget.product.variants?.entries.toList().map((e) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'SELECT ${e.key.toUpperCase()}',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color(0xff515c6f).withOpacity(0.502),
                              letterSpacing: 1),
                        ),
                      ),
                    ),
                    if (e.key == 'color')
                      SelectedColor(
                        colors: List<int>.from(e.value),
                        selectedColorCallBack: (color) {
                          Provider.of<CartProvider>(context, listen: false)
                              .cartItem
                              ?.selectedVarints ??= {};

                          Provider.of<CartProvider>(context, listen: false)
                              .cartItem
                              ?.selectedVarints?[e.key] = color.value;
                        },
                      )
                    else
                      SelectedSize(
                        selectedValueCallBack: (value) {
                          Provider.of<CartProvider>(context, listen: false)
                              .cartItem
                              ?.selectedVarints ??= {};

                          Provider.of<CartProvider>(context, listen: false)
                              .cartItem
                              ?.selectedVarints?[e.key] = value;
                        },
                        values: List<dynamic>.from(e.value),
                      ),
                  ],
                );
              }) ??
              [SizedBox.fromSize()]),
        ],
      ),
    );
  }
}
