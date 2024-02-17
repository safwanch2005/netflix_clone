import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'model_json.dart';

class MovieService {
  Future<List<ApiDataModel>> getMovies(String category) async {
    final url = Uri.parse('${ApiConfig.baseUrl}$category${ApiConfig.apiKey}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => ApiDataModel.fromJson(json)).toList();
    } else {
      throw Exception('Could Not Fetch Movies');
    }
  }

  // Future<List<ApiDataModel>> get(String catagory) async {
  //   final url= Uri.parse("");
  //   http.post(url);
  // }
}
