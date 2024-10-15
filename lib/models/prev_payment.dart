class PrevPaymentModel {
  final String? title;
  final String? description;
  final String? amount;
  final String? date;

  PrevPaymentModel({
    this.title,
    this.description,
    this.amount,
    this.date,
  });

  // Factory constructor to create a PrevPaymentModel from a JSON map
  factory PrevPaymentModel.fromJson(Map<String, dynamic> json) {
    return PrevPaymentModel(
      title: json['title'] as String?,
      description: json['description'] as String?,
      amount: json['amount'] as String?,
      date: json['date'] as String?,
    );
  }

  // Method to convert a PrevPaymentModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'amount': amount,
      'date': date,
    };
  }
}


// class PrevPaymentModel {
//   final String title;
//   final String description;
//   final String amount;
//   final String date;

//   PrevPaymentModel({
//     required this.title,
//     required this.description,
//     required this.amount,
//     required this.date,
//   });

//   // Factory constructor to create a PrevPaymentModel from a JSON map
//   factory PrevPaymentModel.fromJson(Map<String, dynamic> json) {
//     return PrevPaymentModel(
//       title: json['title'] as String,
//       description: json['description'] as String,
//       amount: json['amount'] as String,
//       date: json['date'] as String,
//     );
//   }

//   // Method to convert a PrevPaymentModel to a JSON map
//   Map<String, dynamic> toJson() {
//     return {
//       'title': title,
//       'description': description,
//       'amount': amount,
//       'date': date,
//     };
//   }
// }
