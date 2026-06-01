import 'package:flutter/material.dart';
import '../../model/song.dart';

class AlbumArt extends StatelessWidget {
  final Song song;

  const AlbumArt({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            song.color.withOpacity(0.7),
            song.color.withOpacity(0.15),
            const Color(0xFF181818),
          ],
          radius: 0.85,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: song.color.withOpacity(0.35),
            blurRadius: 48,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Icon(
        Icons.music_note_rounded,
        size: 100,
        color: Colors.white.withOpacity(0.6),
      ),
    );
  }
}
