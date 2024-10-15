import 'dart:async';
import 'dart:convert';
import 'package:the_bhm_app_bloc/models/mess_menu.dart';

class MessMenuProvider {
  Future<List<MessMenuModel>> fetchMessMenu() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Dummy data as provided
    const String dummyJson = '''
    {
      "10": {
        "Breakfast": ["Tea", "Paneer Pakoda", "Idli"],
        "Lunch": ["Rice", "Dal", "Sabji"],
        "Dinner": ["Roti", "Paneer Curry", "Salad"]
      },
      "11": {
        "Breakfast": ["Coffee", "Toast", "Boiled Egg"],
        "Lunch": ["Noodles", "Spring Rolls", "Soup"],
        "Dinner": ["Pasta", "Garlic Bread", "Ice Cream"]
      },
      "12": {
        "Breakfast": ["Juice", "Cereal", "Banana"],
        "Lunch": ["Burger", "Fries", "Coleslaw"],
        "Dinner": ["Pizza", "Wings", "Coke"]
      },
      "13": {
        "Breakfast": ["Paratha", "Curd", "Pickle"],
        "Lunch": ["Biryani", "Raita", "Papad"],
        "Dinner": ["Chowmein", "Manchurian", "Soup"]
      },
      "14": {
        "Breakfast": ["Oatmeal", "Fruit Salad", "Milk"],
        "Lunch": ["Sandwich", "Chips", "Juice"],
        "Dinner": ["Grilled Chicken", "Veg Salad", "Dessert"]
      },
      "15": {
        "Breakfast": ["Poha", "Sev", "Chai"],
        "Lunch": ["Thali", "Dal", "Rice", "Chapati"],
        "Dinner": ["Tacos", "Nachos", "Salsa"]
      },
      "16": {
        "Breakfast": ["Smoothie", "Toast", "Eggs"],
        "Lunch": ["Sushi", "Miso Soup", "Edamame"],
        "Dinner": ["BBQ", "Cornbread", "Coleslaw"]
      }
    }
    ''';

    final Map<String, dynamic> data = json.decode(dummyJson);
    final List<MessMenuModel> menus = data.entries.map((entry) {
      return MessMenuModel.fromJson(entry.key, entry.value);
    }).toList();

    return menus;
  }
}
