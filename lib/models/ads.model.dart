import 'package:shopify_app/models/category.model.dart';

class Ads {
  String? title;
  String? id;
  String? name;
  double? price;
  String? description;
  String? image;
  CategoryData? category;
  DateTime? createdAt;

  Ads();

  Ads.fromJson(Map<String, dynamic> data, [String? docId]) {
    id = docId;
    name = data['name'];
    price = data['price'] is int
        ? (data['price'] as int).toDouble()
        : data['price'];
    image = data['image'];
    description = data['description'];
    category = data['category'] != null
        ? CategoryData.fromJson(data['category'])
        : null;
    createdAt = DateTime.fromMillisecondsSinceEpoch(
        data['createdAt'].millisecondsSinceEpoch);
    title = data['title'];
    // variants = data['variants'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "price": price,
      "image": image,
      "description": description,
      "category": category?.toJson(),
      "createdAt": createdAt,
      "title": title,
    };
  }
}
