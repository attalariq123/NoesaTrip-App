import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:noesatrip_app/helpers/http_exception.dart';

class Destination with ChangeNotifier {
  int id;
  String kode;
  String name;
  String description;
  String price;
  String city;
  String imagePath;
  String overallRating;
  int totalReview;
  bool isFavorite;

  Destination({
    required this.id,
    required this.kode,
    required this.name,
    required this.description,
    required this.price,
    required this.city,
    required this.imagePath,
    required this.overallRating,
    required this.totalReview,
    this.isFavorite = false,
  });

  void toggleFovoriteStatus(String? userId, String? token) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    final url =
        Uri.parse('http://localhost:8000/api/favorite-status/$userId/$id');

    try {
      // print('$userId, $token, $id, $isFavorite');
      final res = await http.put(
        url,
        headers: {"Authorization": "Bearer $token"},
        body: json.encode(
          {
            "isFavorite": isFavorite,
          },
        ),
      );
      // print(res.body);

      if (res.statusCode >= 400) {
        throw HttpException('Could not change favorite status');
      }
    } catch (error) {
      isFavorite = oldStatus;

      notifyListeners();
      throw HttpException('Could not change favorite status');
    }
  }

  factory Destination.fromJson(Map<String, dynamic> json, bool? status) =>
      Destination(
        id: json["id"],
        kode: json["kode"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        city: json["city"],
        imagePath: json["image_path"],
        overallRating: json["overall_rating"],
        totalReview: json["total_review"],
        isFavorite: status!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode": kode,
        "name": name,
        "description": description,
        "price": price,
        "city": city,
        "image_path": imagePath,
        "overall_rating": overallRating,
        "total_review": totalReview,
      };
}
