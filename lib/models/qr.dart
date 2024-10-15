class QRModel {
  final String imgUrl;
  final String name;
  final String hostel;
  final DateTime time;

  // Constructor
  QRModel({
    required this.imgUrl,
    required this.name,
    required this.hostel,
    required this.time,
  });

  // Factory constructor for creating an instance from JSON
  factory QRModel.fromJson(Map<String, dynamic> json) {
    return QRModel(
      imgUrl: json['imgUrl'] as String? ?? '',
      name: json['name'] as String? ?? '',
      hostel: json['hostel'] as String? ?? '',
      time: DateTime.tryParse(json['time'] as String? ?? '') ?? DateTime.now(),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'imgUrl': imgUrl,
      'name': name,
      'hostel': hostel,
      'time': time.toIso8601String(),
    };
  }
}



// class QRModel {
//   final String? imgUrl;
//   final String? name;
//   final String? hostel;
//   final String? time;

//   // Constructor
//   QRModel({this.imgUrl, this.name, this.hostel, this.time});

//   // Factory constructor for creating an instance from JSON
//   factory QRModel.fromJson(Map<String, dynamic> json) {
//     return QRModel(
//       imgUrl: json['imgUrl'] as String?,
//       name: json['name'] as String?,
//       hostel: json['hostel'] as String?,
//       time: json['time'] as String?,
//     );
//   }

//   // Method to convert an instance to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'imgUrl': imgUrl,
//       'name': name,
//       'hostel': hostel,
//       'time': time,
//     };
//   }
// }
