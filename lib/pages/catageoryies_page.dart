import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify_app/models/category.model.dart';
import 'package:shopify_app/models/product.model.dart';
import 'package:shopify_app/providers/category.provider.dart';
import 'package:shopify_app/providers/product.provider.dart';
import 'package:shopify_app/widgets/home/categories_row.home.widget.dart';
import 'package:shopify_app/widgets/home/category.column.dart';
import 'package:shopify_app/widgets/home/category_item_row.home.widget.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  CategoryData? selectedCategory;
  List<Product> displayedProducts = [];

  Future<void> displayProductsByCategory(String? categoryId) async {
    if (categoryId != null) {
      List<Product>? products =
          await ProductProvider().getProductsByCategory(categoryId);

      if (products != null) {
        setState(() {
          displayedProducts = products;
        });
      } else {
        // Handle error retrieving products
      }
    }
  }

  void onCategorySelected(CategoryData? category) {
    if (category != null) {
      setState(() {
        selectedCategory = category;
      });
      displayProductsByCategory(category.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final CategoryData categoryData;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: FutureBuilder<List<CategoryData>?>(
              future: CategoryProvider().getCategories(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final categories = snapshot.data!;
                  return ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return ListTile(
                        title: Text(category.title ?? ''),
                        onTap: () => onCategorySelected(category),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No categories available'));
                }
              },
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.grey[200],
              child: ListView.builder(
                itemCount: displayedProducts.length,
                itemBuilder: (context, index) {
                  Product product = displayedProducts[index];
                  return ListTile(
                    leading: Image.network(product.image.toString()),
                    title: Text(product.name.toString()),
                    /*trailing: Consumer<CategoryProvider>(
                      builder: (__, CategoryProvider, _) {
                        return FutureBuilder(
                            future: CategoryProvider.getCategories(context,
                                limit: 3),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return Text('Error While Get Data');
                                } else if (snapshot.hasData) {
                                  return Category_colum_category(
                                    categoryData: categoryData,
                                    categories: [],
                                  );
                                } else {
                                  return Text('No Data Found');
                                }
                              } else {
                                return Text(
                                    'Connection Statue ${snapshot.connectionState}');
                              }
                            });
                      },
                    ),*/
                    subtitle: Text('\$${product.price}'),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
