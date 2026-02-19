class Book {
  final String id;
  final String title;
  final String author;
  final String thumbnail;
  final String description;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.thumbnail,
    required this.description,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'] ?? {};

    return Book(
      id: json['id'] ?? '',
      title: volumeInfo['title'] ?? '',
      author:
          (volumeInfo['authors'] != null &&
              (volumeInfo['authors'] as List).isNotEmpty)
          ? volumeInfo['authors'][0]
          : '',
      description: volumeInfo['description'] ?? '',
      thumbnail: volumeInfo['imageLinks']?['thumbnail'] ?? '',
    );
  }
}
