import 'package:flutter/material.dart';
import 'package:shopify_app/models/category.model.dart';

class Category_colum_category extends StatelessWidget {
  const Category_colum_category(
      {super.key,
      required this.categoryData,
      required List<CategoryData> categories});
  final CategoryData categoryData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Color(categoryData.shadowColor ?? 0),
                    offset: const Offset(0, 10),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors:
                      categoryData.colors?.map((e) => Color(e)).toList() ?? []),
              shape: BoxShape.circle),
          child: Padding(
            padding: EdgeInsets.only(top: categoryData.image != null ? 10 : 0),
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Text(
          categoryData.title ?? 'No Title',
          style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color(0xff515C6F)),
        )
      ],
    );
  }
}
