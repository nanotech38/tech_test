import 'package:flutter/material.dart';
import '../../const/app_theme_const.dart';
import '../../model/surah_model.dart';

class PlaybackControls extends StatelessWidget {
  final SurahModel surah;
  final bool isPlaying;
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
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.skip_previous_rounded),
          color: kWhite,
          iconSize: 44,
          onPressed: onPrevious,
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
                  color: surah.color.withOpacity(0.5),
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
          icon: const Icon(Icons.skip_next_rounded),
          color: kWhite,
          iconSize: 44,
          onPressed: onNext,
        ),
      ],
    );
  }
}
