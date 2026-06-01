import 'package:flutter/material.dart';
import '../../model/song.dart';

class SongTile extends StatelessWidget {
  final Song song;
  final bool isActive;
  final VoidCallback onTap;

  const SongTile({
    super.key,
    required this.song,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      onTap: onTap,
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: song.color.withOpacity(0.25),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          isActive ? Icons.equalizer_rounded : Icons.music_note_rounded,
          color: isActive ? song.color : Colors.white38,
        ),
      ),
      title: Text(
        song.title,
        style: TextStyle(
          color: isActive ? song.color : Colors.white,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          fontSize: 15,
        ),
      ),
      subtitle: Text(
        song.artist,
        style: const TextStyle(color: Colors.white38, fontSize: 13),
      ),
      trailing: Text(
        song.duration,
        style: const TextStyle(color: Colors.white24, fontSize: 13),
      ),
    );
  }
}
