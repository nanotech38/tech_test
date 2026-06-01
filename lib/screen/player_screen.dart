import 'package:flutter/material.dart';
import '../model/song.dart';
import '../services/navigation_service.dart';
import '../widget/player/album_art.dart';
import '../widget/player/playback_controls.dart';

class PlayerScreen extends StatefulWidget {
  final Song song;

  const PlayerScreen({super.key, required this.song});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  bool _isPlaying = false;
  double _progress = 0.35;

  // Mock total duration in seconds (matches song.duration display)
  static const double _totalSeconds = 215.0;

  String _formatSeconds(double seconds) {
    final int m = seconds ~/ 60;
    final int s = seconds.toInt() % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final song = widget.song;
    final currentSeconds = _progress * _totalSeconds;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.white,
            size: 32,
          ),
          onPressed: () => NavigationService.get().pop(),
        ),
        title: const Text(
          'Now Playing',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: [
            const Spacer(flex: 2),

            // Album Art
            AlbumArt(song: song),

            const Spacer(flex: 2),

            // Song Info + Favorite
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        song.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        song.artist,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.favorite_border_rounded),
                  color: Colors.white38,
                  onPressed: () {},
                ),
              ],
            ),

            const SizedBox(height: 28),

            // Seek Slider
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 3,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
                activeTrackColor: song.color,
                inactiveTrackColor: Colors.white12,
                thumbColor: Colors.white,
                overlayColor: song.color.withOpacity(0.2),
              ),
              child: Slider(
                value: _progress,
                onChanged: (val) => setState(() => _progress = val),
              ),
            ),

            // Time Labels
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatSeconds(currentSeconds),
                    style: const TextStyle(color: Colors.white38, fontSize: 13),
                  ),
                  Text(
                    _formatSeconds(_totalSeconds),
                    style: const TextStyle(color: Colors.white38, fontSize: 13),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Playback Controls
            PlaybackControls(
              song: song,
              isPlaying: _isPlaying,
              onPlayPause: () => setState(() => _isPlaying = !_isPlaying),
              onPrevious: () {},
              onNext: () {},
            ),

            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
