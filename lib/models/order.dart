class Order {
  String? id;
  DateTime? createdAt;

  Order({required this.id, required this.createdAt});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      createdAt: json['createdAt'].toDate(),
    );
  }
}




//class Order {
//  String?
// id;
// DateTime? createdAt;

// Order();

 //Order.fromJson(Map<String, dynamic> data, [String? docId]) {
 // id = docId;
  //createdAt = DateTime.fromMillisecondsSinceEpoch(
  //      data['createdAt'].millisecondsSinceEpoch);
 //}

 //  Map<String, dynamic> toJson() {
   // return {
  //    "id": id,
   //   "createdAt": createdAt,
  //
  ///  };
 // }
 
//}



  

  



