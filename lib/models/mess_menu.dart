class MessMenuModel {
  final String day;
  final Meals meals;

  MessMenuModel({required this.day, required this.meals});

  // Factory constructor to create a MessMenuModel from JSON
  factory MessMenuModel.fromJson(String day, Map<String, dynamic> json) {
    return MessMenuModel(
      day: day,
      meals: Meals.fromJson(json),
    );
  }
}

class Meals {
  final List<String> breakfast;
  final List<String> lunch;
  final List<String> dinner;

  Meals({
    required this.breakfast,
    required this.lunch,
    required this.dinner,
  });

  // Factory constructor to create a Meals instance from JSON
  factory Meals.fromJson(Map<String, dynamic> json) {
    return Meals(
      breakfast: List<String>.from(json['Breakfast'] ?? []),
      lunch: List<String>.from(json['Lunch'] ?? []),
      dinner: List<String>.from(json['Dinner'] ?? []),
    );
  }
}
