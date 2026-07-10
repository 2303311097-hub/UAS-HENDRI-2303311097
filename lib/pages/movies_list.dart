import 'package:flutter/material.dart';

import '../models/news_model.dart';
import '../services/api_service.dart';
import '../widgets/news_card.dart';
import 'detail_page.dart';

class MoviesList extends StatefulWidget {
  const MoviesList({super.key, this.limit});

  final int? limit;

  @override
  State<MoviesList> createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  late final ApiService _apiService;
  late Future<List<NewsModel>> _newsFuture;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
    _newsFuture = _apiService.fetchSportNews();
  }

  Future<void> _refreshNews() async {
    setState(() {
      _newsFuture = _apiService.fetchSportNews();
    });

    await _newsFuture;
  }

  @override
  void dispose() {
    _apiService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsModel>>(
      future: _newsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return _ErrorState(
            message: 'Data berita gagal dimuat.',
            onRetry: _refreshNews,
          );
        }

        final allNews = snapshot.data ?? [];
        final displayedNews = widget.limit == null
            ? allNews
            : allNews.take(widget.limit!).toList();

        if (displayedNews.isEmpty) {
          return _ErrorState(
            message: 'Belum ada data berita.',
            onRetry: _refreshNews,
          );
        }

        return RefreshIndicator(
          onRefresh: _refreshNews,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: displayedNews.length,
            itemBuilder: (context, index) {
              final news = displayedNews[index];

              return NewsCard(
                news: news,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DetailPage(news: news)),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.wifi_off,
              size: 44,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }
}
