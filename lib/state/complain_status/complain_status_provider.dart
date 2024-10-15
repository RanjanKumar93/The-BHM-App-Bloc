import 'dart:convert';
import 'package:the_bhm_app_bloc/models/complain_status.dart';
// import 'package:http/http.dart' as http;

class ComplainStatusProvider {
  Future<List<ComplainStatusModel>> fetchComplainStatus() async {
    // Uncomment the below code when API is ready
    // final response = await http.get(Uri.parse("apiUrl"));

    // if (response.statusCode == 200) {
    //   List<dynamic> data = json.decode(response.body);
    //   return data.map((json) => ComplainStatusModel.fromJson(json)).toList();
    // } else {
    //   throw Exception('Failed to load complaints');
    // }

    // Dummy data for testing
    List<Map<String, String>> dummyData = [
      {'id': 'Complaint 001', 'title': 'Parking Area', 'status': 'Open'},
      {'id': 'Complaint 002', 'title': 'No Cleanliness in Boys Bathroom', 'status': 'Pending'},
      {'id': 'Complaint 003', 'title': 'Broken Bench', 'status': 'Closed'},
      {'id': 'Complaint 004', 'title': 'No Water in Bathroom', 'status': 'Open'},
      {'id': 'Complaint 005', 'title': 'Ragging in Class', 'status': 'Resolved'},
    ];

    // Simulate API response by converting dummy data to JSON
    String jsonString = jsonEncode(dummyData);
    List<dynamic> data = jsonDecode(jsonString);

    return data.map((json) => ComplainStatusModel.fromJson(json)).toList();
  }
}
