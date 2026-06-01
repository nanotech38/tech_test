import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_test/bloc/home_cubit.dart';
import 'package:tech_test/const/app_theme_const.dart';
import 'package:tech_test/model/ayah_model.dart';
import 'package:tech_test/model/surah_model.dart';
import 'package:tech_test/services/navigation_service.dart';
import 'package:tech_test/widget/player/album_art.dart';
import 'package:tech_test/widget/player/playback_controls.dart';

class PlayerScreen extends StatefulWidget {
  final SurahModel surah;
  final List<AyahModel> ayahs;
  final int initialIndex;

  const PlayerScreen({
    super.key,
    required this.surah,
    required this.ayahs,
    required this.initialIndex,
  });

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final AudioPlayer _player = AudioPlayer();
  late int _currentIndex;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isReady = false;
  bool _isChanging = false;

  // subscription disimpan agar bisa di-cancel di dispose
  late final StreamSubscription _durationSub;
  late final StreamSubscription _positionSub;
  late final StreamSubscription _stateSub;

  AyahModel get _currentAyah => widget.ayahs[_currentIndex];
  bool get _canPrevious => _currentIndex > 0;
  bool get _canNext => _currentIndex < widget.ayahs.length - 1;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    // simpan ayah pertama yang dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().selectAyah(_currentAyah.numberInSurah);
    });
    _durationSub = _player.onDurationChanged.listen((d) {
      if (mounted) setState(() => _duration = d);
    });
    _positionSub = _player.onPositionChanged.listen((p) {
      if (mounted) setState(() => _position = p);
    });
    _stateSub = _player.onPlayerStateChanged.listen((state) {
      if (mounted && state == PlayerState.playing && !_isReady) {
        setState(() => _isReady = true);
      }
      // Auto next ayah saat playback selesai
      if (mounted && state == PlayerState.completed && _canNext) {
        _changeAyah(_currentIndex + 1);
      }
    });
    _loadAudio();
  }

  Future<void> _loadAudio() async {
    try {
      debugPrint('PlayerScreen: loading ${_currentAyah.audioUrl}');
      await _player.play(UrlSource(_currentAyah.audioUrl));
      debugPrint('PlayerScreen: play called');
    } catch (e, s) {
      debugPrint('PlayerScreen: audio error=$e');
      debugPrint('PlayerScreen: stack=$s');
      if (mounted) setState(() => _isReady = true);
    }
  }

  // Stop player, reset state, lalu load ayah baru
  // _isChanging untuk mencegah jika tombol prev/next dipanggil terlalu cepat
  Future<void> _changeAyah(int newIndex) async {
    if (_isChanging) return;
    _isChanging = true;
    // simpan cubit sebelum async gap
    final homeCubit = context.read<HomeCubit>();
    try {
      await _player.stop();
      setState(() {
        _currentIndex = newIndex;
        _isReady = false;
        _duration = Duration.zero;
        _position = Duration.zero;
      });
      // update ayah terakhir yang diputar
      homeCubit.selectAyah(_currentAyah.numberInSurah);
      await _loadAudio();
    } finally {
      _isChanging = false;
    }
  }

  @override
  void dispose() {
    _durationSub.cancel();
    _positionSub.cancel();
    _stateSub.cancel();
    _player.dispose();
    super.dispose();
  }

  String _formatProgress(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final surah = widget.surah;
    final ayah = _currentAyah;

    return Scaffold(
      backgroundColor: kBgPrimary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: kWhite,
            size: 32,
          ),
          onPressed: () => NavigationService.get().pop(),
        ),
        title: const Text(
          'Now Playing',
          style: TextStyle(color: kWhite, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: [
            const Spacer(flex: 2),

            // Album Art
            AlbumArt(surah: surah),

            const Spacer(flex: 2),

            // Surah Info
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        surah.arabicName,
                        style: const TextStyle(color: kWhite54, fontSize: 18),
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        surah.title,
                        style: const TextStyle(
                          color: kWhite,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Ayah ${ayah.numberInSurah} · ${surah.translation}',
                        style: const TextStyle(color: kWhite54, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // Progress & Controls — tampil loading jika audio belum siap
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _isReady ? _buildControls(surah) : _buildLoading(surah),
            ),

            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading(SurahModel surah) {
    return SizedBox(
      key: const ValueKey('loading'),
      height: 160,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 36,
            height: 36,
            child: CircularProgressIndicator(
              color: surah.color,
              strokeWidth: 2.5,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Menyiapkan audio...',
            style: TextStyle(color: kWhite38, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildControls(SurahModel surah) {
    return Column(
      key: const ValueKey('controls'),
      children: [
        // Progress Slider
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 3,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
            activeTrackColor: surah.color,
            inactiveTrackColor: kWhite12,
            thumbColor: kWhite,
            overlayColor: surah.color.withValues(alpha: 0.2),
          ),
          child: Slider(
            value: _duration.inMilliseconds > 0
                ? (_position.inMilliseconds / _duration.inMilliseconds).clamp(
                    0.0,
                    1.0,
                  )
                : 0.0,
            onChanged: (val) {
              if (_duration != Duration.zero) {
                _player.seek(
                  Duration(
                    milliseconds: (val * _duration.inMilliseconds).round(),
                  ),
                );
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatProgress(_position),
                style: const TextStyle(color: kWhite38, fontSize: 13),
              ),
              Text(
                _formatProgress(_duration),
                style: const TextStyle(color: kWhite38, fontSize: 13),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),

        // Playback Controls
        StreamBuilder<PlayerState>(
          stream: _player.onPlayerStateChanged,
          initialData: _player.state,
          builder: (context, snapshot) {
            final isPlaying = snapshot.data == PlayerState.playing;
            return PlaybackControls(
              surah: surah,
              isPlaying: isPlaying,
              canPrevious: _canPrevious,
              canNext: _canNext,
              onPlayPause: () => isPlaying ? _player.pause() : _player.resume(),
              onPrevious: () => _changeAyah(_currentIndex - 1),
              onNext: () => _changeAyah(_currentIndex + 1),
            );
          },
        ),
      ],
    );
  }
}
