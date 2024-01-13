import 'package:flutter/material.dart';
import 'package:shopify_app/models/product.model.dart';
import 'package:shopify_app/pages/product_details/details.dart';
import 'package:shopify_app/pages/product_details/product.variant.dart';
import 'package:shopify_app/pages/product_details/review.dart';

class PageView_Widget extends StatefulWidget {
  const PageView_Widget({super.key});

  @override
  State<PageView_Widget> createState() => _PageView_WidgetState();
}

class _PageView_WidgetState extends State<PageView_Widget> {
  final PageController controller = PageController(
    initialPage: 0,
  );

  //@override
  //void dispose() {
  // controller.dispose();
  // super.dispose();
  //}

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      reverse: false,
      controller: controller,
      children: <Widget>[
        Variants_Product(
          product: Product.fromJson("docId" as Map<String, dynamic>),
        ),
        Details(),
        Reviews(),
      ],
    );
  }
}
