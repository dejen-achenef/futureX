class VideoModel {
  final int id;
  final String title;
  final String description;
  final String youtubeVideoId;
  final String category;
  final int duration;
  final int userId;
  final DateTime createdAt;

  VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.youtubeVideoId,
    required this.category,
    required this.duration,
    required this.userId,
    required this.createdAt,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      youtubeVideoId: json['youtubeVideoId'] as String? ?? json['youtube_video_id'] as String,
      category: json['category'] as String,
      duration: json['duration'] as int,
      userId: json['userId'] as int? ?? json['user_id'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String? ?? json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'youtubeVideoId': youtubeVideoId,
      'category': category,
      'duration': duration,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  String get thumbnailUrl => 'https://img.youtube.com/vi/$youtubeVideoId/maxresdefault.jpg';
}

