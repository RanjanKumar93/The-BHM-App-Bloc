import 'package:the_bhm_app_bloc/models/qr.dart';

class QRProvider {
  Future<QRModel> getQR() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // TODO: Replace with actual network request, e.g., using http package
      // final response = await http.get(Uri.parse('https://api.example.com/qr'));
      // if (response.statusCode == 200) {
      //   return QRModel.fromJson(jsonDecode(response.body));
      // } else {
      //   throw Exception('Failed to load QR data: ${response.statusCode}');
      // }

      // For now, return mock data
      return QRModel(
        hostel: "Saturn Hostel",
        imgUrl: "https://via.placeholder.com/200",
        name: "RK",
        time: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Error fetching QR data: $e');
    }
  }
}
