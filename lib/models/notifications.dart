class Notification {
  String? id;
  String? title;
  String? description;
  String? NotificationsPictureUrl;
  DateTime? createdAt;

  Notification(
      {String? title, String? description, String? NotificationsPictureUrl});

  Notification.fromJson(Map<String, dynamic> notification, [String? docId]) {
    id = docId;
    title = notification['title'];
    description = notification['description'];
    NotificationsPictureUrl = notification['profilePictureUrl'];
    createdAt = DateTime.fromMillisecondsSinceEpoch(
        notification['createdAt'].millisecondsSinceEpoch);

    Map<String, dynamic> toJson() {
      return {
        "id": id,
        "title": title,
        " description": description,
        "NotificationsPictureUrl": NotificationsPictureUrl,
        "createdAt": createdAt,
      };
    }
  }
}
