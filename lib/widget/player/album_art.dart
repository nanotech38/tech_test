import 'package:flutter/material.dart';
import '../../const/app_theme_const.dart';
import '../../model/surah_model.dart';

class AlbumArt extends StatelessWidget {
  final SurahModel surah;

  const AlbumArt({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            surah.color.withOpacity(0.7),
            surah.color.withOpacity(0.15),
            kBgTertiary,
          ],
          radius: 0.85,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: surah.color.withOpacity(0.35),
            blurRadius: 48,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Icon(Icons.music_note_rounded, size: 100, color: kWhite.withOpacity(0.6)),
    );
  }
}
