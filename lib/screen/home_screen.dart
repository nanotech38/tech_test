import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_test/bloc/home_cubit.dart';
import 'package:tech_test/model/song.dart';
import 'package:tech_test/services/navigation_service.dart';
import 'package:tech_test/widget/homepage/mini_player.dart';
import 'package:tech_test/widget/homepage/song_empty_state.dart';
import 'package:tech_test/widget/homepage/song_search_bar.dart';
import 'package:tech_test/widget/homepage/song_tile.dart';
import 'player_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  Song? _currentSong;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openPlayer(Song song) {
    setState(() => _currentSong = song);
    NavigationService.get().push(PlayerScreen(song: song));
  }

  List<Song> _filtered(List<Song> items) {
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) return items;
    return items.where((s) {
      return s.title.toLowerCase().contains(query) ||
          s.artist.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        title: const Text(
          'Music Player',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SongSearchBar(controller: _searchController),
          Expanded(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state.inLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white38),
                  );
                }

                if (state.rc == 'error') {
                  return _ErrorState(
                    message: state.errorMsg,
                    onRetry: () => context.read<HomeCubit>().loadSongs(),
                  );
                }

                final filtered = _filtered(state.items);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: Text(
                        '${filtered.length} songs',
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Expanded(
                      child: filtered.isEmpty
                          ? const SongEmptyState()
                          : ListView.builder(
                              itemCount: filtered.length,
                              itemBuilder: (context, index) {
                                final song = filtered[index];
                                return SongTile(
                                  song: song,
                                  isActive: _currentSong?.id == song.id,
                                  onTap: () => _openPlayer(song),
                                );
                              },
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
          if (_currentSong != null)
            MiniPlayer(
              song: _currentSong!,
              onTap: () => _openPlayer(_currentSong!),
            ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.wifi_off_rounded, color: Colors.white24, size: 64),
          const SizedBox(height: 16),
          const Text(
            'Failed to load songs',
            style: TextStyle(color: Colors.white54, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: const TextStyle(color: Colors.white24, fontSize: 12),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded, color: Colors.white54),
            label: const Text(
              'Retry',
              style: TextStyle(color: Colors.white54),
            ),
          ),
        ],
      ),
    );
  }
}
