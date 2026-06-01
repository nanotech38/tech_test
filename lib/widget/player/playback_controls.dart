import 'package:flutter/material.dart';
import '../../const/app_theme_const.dart';
import '../../model/surah_model.dart';

class PlaybackControls extends StatelessWidget {
  final SurahModel surah;
  final bool isPlaying;
  final bool canPrevious;
  final bool canNext;
  final VoidCallback onPlayPause;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const PlaybackControls({
    super.key,
    required this.surah,
    required this.isPlaying,
    required this.onPlayPause,
    required this.onPrevious,
    required this.onNext,
    this.canPrevious = true,
    this.canNext = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(
            Icons.skip_previous_rounded,
            // redup jika sudah di ayah pertama
            color: canPrevious ? kWhite : kWhite24,
          ),
          iconSize: 44,
          onPressed: canPrevious ? onPrevious : null,
        ),
        GestureDetector(
          onTap: onPlayPause,
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: surah.color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: surah.color.withValues(alpha: 0.5),
                  blurRadius: 24,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(
              isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
              color: kWhite,
              size: 38,
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.skip_next_rounded,
            // redup jika sudah di ayah terakhir
            color: canNext ? kWhite : kWhite24,
          ),
          iconSize: 44,
          onPressed: canNext ? onNext : null,
        ),
      ],
    );
  }
}
