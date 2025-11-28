import 'dart:convert';
import 'package:http/http.dart' as http;

class YouTubeAPIService {
  final String apiKey;
  static const String baseUrl = 'https://www.googleapis.com/youtube/v3';

  YouTubeAPIService({required this.apiKey});

  /// Validates if a YouTube video ID is valid
  Future<bool> validateVideoId(String videoId) async {
    try {
      final url = Uri.parse(
        '$baseUrl/videos?id=$videoId&key=$apiKey&part=id'
      );
      
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['items'] != null && (data['items'] as List).isNotEmpty;
      }
      
      return false;
    } catch (e) {
      print('Error validating video ID: $e');
      return false;
    }
  }

  /// Fetches video metadata from YouTube API
  Future<YouTubeVideoMetadata?> getVideoMetadata(String videoId) async {
    try {
      final url = Uri.parse(
        '$baseUrl/videos?id=$videoId&key=$apiKey&part=snippet,contentDetails,statistics'
      );
      
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['items'] != null && (data['items'] as List).isNotEmpty) {
          final item = data['items'][0];
          final snippet = item['snippet'];
          final contentDetails = item['contentDetails'];
          final statistics = item['statistics'];
          
          return YouTubeVideoMetadata(
            id: videoId,
            title: snippet['title'],
            description: snippet['description'],
            thumbnailUrl: snippet['thumbnails']['high']['url'] ?? 
                         snippet['thumbnails']['default']['url'],
            duration: _parseDuration(contentDetails['duration']),
            publishedAt: snippet['publishedAt'],
            channelTitle: snippet['channelTitle'],
            viewCount: int.tryParse(statistics['viewCount'] ?? '0') ?? 0,
            likeCount: int.tryParse(statistics['likeCount'] ?? '0') ?? 0,
          );
        }
      }
      
      return null;
    } catch (e) {
      print('Error fetching video metadata: $e');
      return null;
    }
  }

  /// Gets thumbnail URL for a video ID
  static String getThumbnailUrl(String videoId, {String quality = 'maxresdefault'}) {
    return 'https://img.youtube.com/vi/$videoId/$quality.jpg';
  }

  /// Extracts video ID from YouTube URL
  static String? extractVideoId(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;

    // Handle different YouTube URL formats
    if (uri.host.contains('youtube.com')) {
      return uri.queryParameters['v'];
    } else if (uri.host.contains('youtu.be')) {
      return uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
    }

    return null;
  }

  /// Parses ISO 8601 duration to seconds
  int _parseDuration(String duration) {
    final regex = RegExp(r'PT(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?');
    final match = regex.firstMatch(duration);
    
    if (match == null) return 0;

    final hours = int.tryParse(match.group(1) ?? '0') ?? 0;
    final minutes = int.tryParse(match.group(2) ?? '0') ?? 0;
    final seconds = int.tryParse(match.group(3) ?? '0') ?? 0;

    return hours * 3600 + minutes * 60 + seconds;
  }
}

class YouTubeVideoMetadata {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final int duration; // in seconds
  final String publishedAt;
  final String channelTitle;
  final int viewCount;
  final int likeCount;

  YouTubeVideoMetadata({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.duration,
    required this.publishedAt,
    required this.channelTitle,
    required this.viewCount,
    required this.likeCount,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'thumbnailUrl': thumbnailUrl,
      'duration': duration,
      'publishedAt': publishedAt,
      'channelTitle': channelTitle,
      'viewCount': viewCount,
      'likeCount': likeCount,
    };
  }
}

