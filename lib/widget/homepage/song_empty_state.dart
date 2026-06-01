import 'package:flutter/material.dart';

class SongEmptyState extends StatelessWidget {
  const SongEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.music_off_rounded, color: Colors.white12, size: 72),
          SizedBox(height: 16),
          Text(
            'No songs found',
            style: TextStyle(color: Colors.white24, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
