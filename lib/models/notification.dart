class NotificationModel {
  final String? name;
  final String? role;
  final String? imgUrl;
  final String? title;
  final String? body;
  final bool isUnread;
  final bool isStar;

  NotificationModel({
    this.name,
    this.role,
    this.imgUrl,
    this.title,
    this.body,
    this.isUnread = false,
    this.isStar = false,
  });

  // Factory method to create a new instance from a JSON object
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      imgUrl: json['imgurl'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      isUnread: json['isUnread'] ?? false,
      isStar: json['isStar'] ?? false,
    );
  }

  // Convert an instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'role': role,
      'imgurl': imgUrl,
      'title': title,
      'body': body,
      'isUnread': isUnread,
      'isStar': isStar,
    };
  }
}


// class NotificationModel {
//   final String? name;
//   final String? role;
//   final String? imgUrl;
//   final String? title;
//   final String? body;
//   final bool isUnread;
//   final bool isStar;

//   NotificationModel({
//     this.name,
//     this.role,
//     this.imgUrl,
//     this.title,
//     this.body,
//     this.isUnread = false,
//     this.isStar = false,
//   });

//   // Factory method to create a new instance from a JSON object
//   factory NotificationModel.fromJson(Map<String, dynamic> json) {
//     return NotificationModel(
//       name: json['name'] ?? '',
//       role: json['role'] ?? '',
//       imgUrl: json['imgurl'] ?? '',
//       title: json['title'] ?? '',
//       body: json['body'] ?? '',
//     );
//   }

//   // Convert an instance to a JSON object
//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'role': role,
//       'imgurl': imgUrl,
//       'title': title,
//       'body': body,
//     };
//   }
// }
