import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: VideoLearningApp(),
    ),
  );
}

class VideoLearningApp extends ConsumerWidget {
  const VideoLearningApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return MaterialApp(
      title: 'Video Learning App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: authState.isAuthenticated
          ? const HomeScreen()
          : const LoginScreen(),
    );
  }
}

