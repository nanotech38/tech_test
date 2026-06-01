import 'package:flutter/material.dart';
import '../../model/song.dart';

class PlaybackControls extends StatelessWidget {
  final Song song;
  final bool isPlaying;
  final VoidCallback onPlayPause;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const PlaybackControls({
    super.key,
    required this.song,
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
          color: Colors.white,
          iconSize: 44,
          onPressed: onPrevious,
        ),
        GestureDetector(
          onTap: onPlayPause,
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: song.color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: song.color.withOpacity(0.5),
                  blurRadius: 24,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(
              isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
              color: Colors.white,
              size: 38,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.skip_next_rounded),
          color: Colors.white,
          iconSize: 44,
          onPressed: onNext,
        ),
      ],
    );
  }
}
