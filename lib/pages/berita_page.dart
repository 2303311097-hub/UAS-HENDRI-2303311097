import 'package:flutter/material.dart';

import 'movies_list.dart';

class BeritaPage extends StatelessWidget {
  const BeritaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Berita')),
      body: const MoviesList(),
    );
  }
}
