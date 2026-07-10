import 'package:flutter/material.dart';

import '../models/news_model.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.news});

  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Berita')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            news.section,
            style: textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            news.headline,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.person_outline, size: 18),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  news.author.isEmpty ? 'Tanpa penulis' : news.author,
                  style: textTheme.bodyMedium,
                ),
              ),
              const SizedBox(width: 8),
              Text(news.formattedDate),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            news.abstractText,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          Text(
            news.cleanBody.isEmpty ? news.body : news.cleanBody,
            style: textTheme.bodyLarge?.copyWith(height: 1.45),
          ),
        ],
      ),
    );
  }
}
