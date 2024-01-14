import 'package:flutter/material.dart';
import 'package:shopify_app/models/product.model.dart';
import 'package:shopify_app/pages/product_details/details.dart';
import 'package:shopify_app/pages/product_details/product.variant.dart';
import 'package:shopify_app/pages/product_details/review.dart';

class PageView_Widget extends StatefulWidget {
  const PageView_Widget({Key? key}) : super(key: key);

  @override
  State<PageView_Widget> createState() => _PageView_WidgetState();
}

class _PageView_WidgetState extends State<PageView_Widget> {
  late PageController _pageController;
  int _currentPageIndex = 0;
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            children: <Widget>[
              Variants_Product(
                product: Product.fromJson({"docId??": "id"}),
              ),
              Details(),
              Reviews(),
            ],
          ),
        ),
      ],
    );
  }
}
