class UserProfile {
  String? id;
  String? name;
  String? email;
  String? profilePictureUrl;
  DateTime? createdAt;
  String? phone;
  //String? address;

  UserProfile({
    String? name,
    String? phone,
    String? email,
    /*String? address*/
  });

  UserProfile.fromJson(Map<String, dynamic> user, [String? docId]) {
    id = docId;
    name = user['name'];
    email = user['email'];
    profilePictureUrl = user['profilePictureUrl'];
    createdAt = DateTime.fromMillisecondsSinceEpoch(
        user['createdAt'].millisecondsSinceEpoch);
    phone = user['phone'];
    //address = user['address'];

    Map<String, dynamic> toJson() {
      return {
        "id": id,
        "name": name,
        "email": email,
        "profilePictureUrl": profilePictureUrl,
        "createdAt": createdAt,
        "phone": phone,
        // "address": address,
      };
    }
  }
}
