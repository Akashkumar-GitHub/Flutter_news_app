# Flutter News App

A simple Flutter application that fetches and displays the latest news headlines using [NewsAPI.org](https://newsapi.org/).

# Features
- Fetch top news headlines from the US.
- Displays article title, source, and thumbnail.
- Tap an article to view it in a browser.
- Pull to refresh for updated headlines.

## Tools & Technologies
- Flutter
- Dart
- HTTP package
- url_launcher

##  API Key Setup
1. Create a free account on [NewsAPI.org](https://newsapi.org/).
2. Copy API key.
3. place in `news_service.dart` with API key.

##  How to Run
```bash
flutter pub get
flutter run
```

## UI Preview
- List of headlines
- Thumbnail images
- Pull-to-refresh functionality
