import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify_app/models/category.model.dart';
import 'package:shopify_app/models/product.model.dart';
import 'package:shopify_app/pages/cart.page.dart';
import 'package:shopify_app/pages/home_page.dart';
import 'package:shopify_app/providers/cart.provider.dart';
import 'package:shopify_app/providers/category.provider.dart';
import 'package:shopify_app/providers/product.provider.dart';
import 'package:shopify_app/widgets/button_icon.widget.dart';
import 'package:shopify_app/widgets/home/categories_row.home.widget.dart';
import 'package:shopify_app/widgets/home/category.column.dart';
import 'package:shopify_app/widgets/home/category_item_row.home.widget.dart';
import 'package:uuid/uuid.dart';

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
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => CartPage()));
          },
          icon: Icon(Icons.arrow_back, color: Color(0xffff6969), size: 18),
        ),
        title: const Text('All Products',
            style: TextStyle(fontWeight: FontWeight.w600)),
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
                        title: Text(
                          category.title ?? '',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
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
            child: Card(
              child: Container(
                color: Colors.grey[200],
                child: Card(
                  child: ListView.builder(
                    itemCount: displayedProducts.length,
                    itemBuilder: (context, index) {
                      Product product = displayedProducts[index];
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Provider.of<CartProvider>(context, listen: false)
                                .cartItem
                                ?.productId = product.id.toString();
                            Provider.of<CartProvider>(context, listen: false)
                                .cartItem
                                ?.quantity = 1;
                            Provider.of<CartProvider>(context, listen: false)
                                .cartItem
                                ?.itemId = Uuid().v4();
                            Provider.of<CartProvider>(context, listen: false)
                                .onAddItemToCart(context: context);
                          },
                          tileColor: Colors.white,
                          leading: Image.network(product.image.toString()),
                          title: Text(product.name.toString(),
                              style: TextStyle(
                                  color: Color(0xff515C6F),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
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
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
