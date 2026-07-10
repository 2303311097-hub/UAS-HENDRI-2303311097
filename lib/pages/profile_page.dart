import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          SizedBox(height: 24),
          Center(child: _ProfilePhoto()),
          SizedBox(height: 20),
          Center(
            child: Text(
              'Hendri',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 24),
          _ProfileInfo(label: 'NIM', value: '2303311097'),
          _ProfileInfo(label: 'Prodi', value: 'Informatika'),
          _ProfileInfo(
            label: 'Kampus',
            value: 'Universitas Satya Terra Bhinneka',
          ),
          _ProfileInfo(label: 'Aplikasi', value: 'Sport News'),
        ],
      ),
    );
  }
}

class _ProfilePhoto extends StatelessWidget {
  const _ProfilePhoto();

  static const String _assetPath = 'lib/assets/images/profile_photo.png';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 128,
      height: 128,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: colorScheme.primary, width: 3),
        color: colorScheme.primaryContainer,
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        _assetPath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Icons.person_outline,
            size: 64,
            color: colorScheme.onPrimaryContainer,
          );
        },
      ),
    );
  }
}

class _ProfileInfo extends StatelessWidget {
  const _ProfileInfo({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        title: Text(label),
        subtitle: Text(value, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
