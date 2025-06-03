import 'dart:conert';
import 'package:http/http.dart' as http;
class NewsService{
  final String apikey = "bb54f6dc93ba4d68a2bb35d6efd4bfdd";
  final String baseUrl = "https://newsapi.org/v2/top-headlines?country=us&apikey=bb54f6dc93ba4d68a2bb35d6efd4bfdd";

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
