import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  final String apiKey = "bb54f6dc93ba4d68a2bb35d6efd4b5dd"; 
  final String baseUrl = "https://newsapi.org/v2/top-headlines?country=us";

  Future<List<dynamic>> fetchNews() async {
    final response = await http.get(Uri.parse('$baseUrl$apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
