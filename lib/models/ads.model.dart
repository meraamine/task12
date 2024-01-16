class Ads {
  String? id;
  String? title;
  String? image;
  String? description;

  Ads({this.id, this.title, this.image, this.description});

  Ads.fromJson(Map<String, dynamic> json, String docId) {
    id = docId;
    title = json['title'];
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['description'] = description;
    return data;
  }
}
