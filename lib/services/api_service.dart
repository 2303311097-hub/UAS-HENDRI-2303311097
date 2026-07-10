import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/news_model.dart';

class ApiService {
  ApiService({http.Client? client}) : _client = client ?? http.Client();

  static const String _sportNewsUrl = 'https://fakenews.squirro.com/news/sport';
  static const String _cachedSportNewsPath = 'lib/assets/data/sport_news.json';

  final http.Client _client;

  Future<List<NewsModel>> fetchSportNews() async {
    try {
      final response = await _client.get(Uri.parse(_sportNewsUrl));

      if (response.statusCode != 200) {
        throw Exception(
          'Gagal mengambil data berita (${response.statusCode}).',
        );
      }

      return _parseNews(response.body);
    } catch (_) {
      final cachedResponse = await rootBundle.loadString(_cachedSportNewsPath);
      return _parseNews(cachedResponse);
    }
  }

  void close() {
    _client.close();
  }

  List<NewsModel> _parseNews(String responseBody) {
    final decoded = jsonDecode(responseBody);
    if (decoded is! Map<String, dynamic> || decoded['news'] is! List) {
      throw Exception('Format data berita tidak sesuai.');
    }

    final newsItems = decoded['news'] as List<dynamic>;
    return newsItems
        .whereType<Map<String, dynamic>>()
        .map(NewsModel.fromJson)
        .toList();
  }
}
