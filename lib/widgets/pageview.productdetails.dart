import 'package:flutter/material.dart';

class PageView_Widget extends StatefulWidget {
  const PageView_Widget({super.key});

  @override
  State<PageView_Widget> createState() => _PageView_WidgetState();
}

class _PageView_WidgetState extends State<PageView_Widget> {
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      /// [PageView.scrollDirection] defaults to [Axis.horizontal].
      /// Use [Axis.vertical] to scroll vertically.
      controller: controller,
      children: const <Widget>[
        Center(
          child: Text('Product'),
        ),
        Center(
          child: Text('Details'),
        ),
        Center(
          child: Text('Review'),
        ),
      ],
    );
  }
}
