import '../models/video_model.dart';
import '../../core/network/api_service.dart';

class VideoRepository {
  final ApiService _apiService;

  VideoRepository(this._apiService);

  Future<List<VideoModel>> getAllVideos({
    String? search,
    String? category,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }
      if (category != null && category.isNotEmpty) {
        queryParams['category'] = category;
      }

      final response = await _apiService.get('/videos', queryParameters: queryParams);
      final List<dynamic> videosJson = response.data['data'] as List<dynamic>;

      return videosJson.map((json) => VideoModel.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Failed to fetch videos: ${e.toString()}');
    }
  }

  Future<VideoModel> getVideoById(int id) async {
    try {
      final response = await _apiService.get('/videos/$id');
      return VideoModel.fromJson(response.data['data'] as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to fetch video: ${e.toString()}');
    }
  }
}

