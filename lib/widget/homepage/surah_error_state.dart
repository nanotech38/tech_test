import 'package:flutter/material.dart';
import '../../const/app_theme_const.dart';

class SurahErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const SurahErrorState({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.wifi_off_rounded, color: kWhite24, size: 64),
          const SizedBox(height: 16),
          const Text(
            'Failed to load surahs',
            style: TextStyle(color: kWhite54, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: const TextStyle(color: kWhite24, fontSize: 12),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded, color: kWhite54),
            label: const Text('Retry', style: TextStyle(color: kWhite54)),
          ),
        ],
      ),
    );
  }
}
