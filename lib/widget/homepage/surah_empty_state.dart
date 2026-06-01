import 'package:flutter/material.dart';
import '../../const/app_theme_const.dart';

class SurahEmptyState extends StatelessWidget {
  const SurahEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.music_off_rounded, color: kWhite12, size: 72),
          SizedBox(height: 16),
          Text(
            'No Surah found',
            style: TextStyle(color: kWhite24, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
