class NewsModel {
  const NewsModel({
    required this.id,
    required this.headline,
    required this.abstractText,
    required this.body,
    required this.author,
    required this.section,
    required this.date,
    required this.articleUri,
    required this.pdfUri,
  });

  final int id;
  final String headline;
  final String abstractText;
  final String body;
  final String author;
  final String section;
  final DateTime? date;
  final String articleUri;
  final String pdfUri;

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: _readInt(json['id']),
      headline: _readString(json['headline']),
      abstractText: _readString(json['abstract']),
      body: _readString(json['body']),
      author: _readString(json['author']),
      section: _readString(json['section']),
      date: DateTime.tryParse(_readString(json['date'])),
      articleUri: _readString(json['article_uri']),
      pdfUri: _readString(json['pfd_uri']),
    );
  }

  String get formattedDate {
    final value = date;
    if (value == null) return '-';

    return '${value.day.toString().padLeft(2, '0')}/'
        '${value.month.toString().padLeft(2, '0')}/'
        '${value.year}';
  }

  String get cleanBody {
    return body
        .replaceAll(RegExp(r'<\/p>\s*', caseSensitive: false), '\n\n')
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll(RegExp(r'\n{3,}'), '\n\n')
        .trim();
  }

  static int _readInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static String _readString(dynamic value) {
    return value?.toString().trim() ?? '';
  }
}
