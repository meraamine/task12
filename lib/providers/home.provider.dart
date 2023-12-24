import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopify_app/models/ads.model.dart';
import 'package:shopify_app/utils/collections.utils.dart';
import '../models/category.model.dart';

class HomeProvider extends ChangeNotifier {
  List<Ads>? adList;
  List<CategoryData>? categorieslist;

  void initHomeProvider() async {
    await getAds();
    getCategoriesList();
  }

  Future<void> getAds() async {
    QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
        .instance
        .collection(CollectionsUtils.ads.name)
        .get();
    adList =
        List<Ads>.from(result.docs.map((e) => Ads.fromJson(e.data(), e.id)));
    notifyListeners();
  }

    Future<void> getCategoriesList() async {
    QuerySnapshot<Map<String, dynamic>> cat = await FirebaseFirestore
        .instance
        .collection(CollectionsUtils.CategoryData.name)
        .get();
    categorieslist =
    List<CategoryData>.from(cat.docs.map((e) => CategoryData.fromJson(e.data(), e.id)));
    notifyListeners();
  }
}
