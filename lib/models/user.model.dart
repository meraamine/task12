class UserProfile {
  String? id;
  String? name;
  String? email;
  String? profilePictureUrl;
  DateTime? createdAt;
  String? phone;

  UserProfile({String? name, String? phone, String? email});

  UserProfile.fromJson(Map<String, dynamic> user, [String? docId]) {
    id = docId;
    name = user['name'];
    email = user['email'];
    profilePictureUrl = user['profilePictureUrl'];
    createdAt = DateTime.fromMillisecondsSinceEpoch(
        user['createdAt'].millisecondsSinceEpoch);
    phone = user['phone'];

    Map<String, dynamic> toJson() {
      return {
        "id": id,
        "name": name,
        "email": email,
        "profilePictureUrl": profilePictureUrl,
        "createdAt": createdAt,
        "phone": phone,
      };
    }
  }
}
