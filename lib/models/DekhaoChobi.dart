
class DekhaoChobiModel {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  DekhaoChobiModel({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory DekhaoChobiModel.fromJson(Map<String, dynamic> json) {
    return DekhaoChobiModel(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}