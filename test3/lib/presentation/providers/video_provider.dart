import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/video_model.dart';
import '../../data/repositories/video_repository.dart';
import 'auth_provider.dart';

final videoRepositoryProvider = Provider<VideoRepository>((ref) {
  return VideoRepository(ref.read(apiServiceProvider));
});

class VideoListState {
  final List<VideoModel> videos;
  final bool isLoading;
  final String? error;
  final String? searchQuery;
  final String? categoryFilter;

  VideoListState({
    this.videos = const [],
    this.isLoading = false,
    this.error,
    this.searchQuery,
    this.categoryFilter,
  });

  VideoListState copyWith({
    List<VideoModel>? videos,
    bool? isLoading,
    String? error,
    String? searchQuery,
    String? categoryFilter,
  }) {
    return VideoListState(
      videos: videos ?? this.videos,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      searchQuery: searchQuery ?? this.searchQuery,
      categoryFilter: categoryFilter ?? this.categoryFilter,
    );
  }
}

class VideoListNotifier extends StateNotifier<VideoListState> {
  final VideoRepository _videoRepository;

  VideoListNotifier(this._videoRepository) : super(VideoListState()) {
    loadVideos();
  }

  Future<void> loadVideos({String? search, String? category}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final videos = await _videoRepository.getAllVideos(
        search: search ?? state.searchQuery,
        category: category ?? state.categoryFilter,
      );
      state = state.copyWith(
        videos: videos,
        isLoading: false,
        searchQuery: search,
        categoryFilter: category,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void setSearch(String query) {
    loadVideos(search: query);
  }

  void setCategory(String category) {
    loadVideos(category: category);
  }

  void refresh() {
    loadVideos();
  }
}

final videoListProvider = StateNotifierProvider<VideoListNotifier, VideoListState>((ref) {
  return VideoListNotifier(ref.read(videoRepositoryProvider));
});

