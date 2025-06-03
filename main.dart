import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'news_service.dart';

void main() {
  runApp(NewsApp());
}

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Top News Headlines',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: NewsScreen(),
    );
  }
}

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final NewsService _newsService = NewsService();
  late Future<List<dynamic>> _newsList;

  @override
  void initState() {
    super.initState();
    _newsList = _newsService.fetchNews();
  }

  Future<void> _refreshNews() async {
    setState(() {
      _newsList = _newsService.fetchNews();
    });
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Top Headlines')),
      body: RefreshIndicator(
        onRefresh: _refreshNews,
        child: FutureBuilder<List<dynamic>>(
          future: _newsList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final articles = snapshot.data!;
              return ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: article['urlToImage'] != null
                          ? Image.network(article['urlToImage'], width: 100, fit: BoxFit.cover)
                          : Container(width: 100, color: Colors.grey),
                      title: Text(article['title'] ?? 'No Title'),
                      subtitle: Text(article['source']['name'] ?? 'Unknown Source'),
                      onTap: () {
                        if (article['url'] != null) {
                          _launchURL(article['url']);
                        }
                      },
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Failed to load news: ${snapshot.error}'));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
