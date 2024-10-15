class HomeImagesModel {
  final List<String> data;

  HomeImagesModel({required this.data});

  // Factory constructor to create an instance from JSON
  factory HomeImagesModel.fromJson(Map<String, dynamic> json) {
    return HomeImagesModel(
      data: List<String>.from(json['data']), // Assuming 'data' is the key for the list in the response
    );
  }

  // Method to convert the object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'data': data,
    };
  }
}
