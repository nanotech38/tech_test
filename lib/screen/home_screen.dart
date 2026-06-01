import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_test/bloc/ayah_cubit.dart';
import 'package:tech_test/bloc/home_cubit.dart';
import 'package:tech_test/const/app_rc_const.dart';
import 'package:tech_test/const/app_theme_const.dart';
import 'package:tech_test/model/surah_model.dart';
import 'package:tech_test/services/navigation_service.dart';
import 'package:tech_test/widget/homepage/mini_player.dart';
import 'package:tech_test/widget/homepage/surah_empty_state.dart';
import 'package:tech_test/widget/homepage/surah_error_state.dart';
import 'package:tech_test/widget/homepage/surah_search_bar.dart';
import 'package:tech_test/widget/homepage/surah_title.dart';
import 'ayah_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  // cache filter agar tidak dijalankan ulang tiap rebuild
  List<SurahModel> _cachedFiltered = const [];
  String _lastQuery = '';
  List<SurahModel>? _lastItems;

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

  // navigate ke ayah selection screen
  void _openPlayer(SurahModel surah) {
    context.read<HomeCubit>().selectSurah(surah);
    NavigationService.get().push(
      BlocProvider(
        create: (_) => AyahCubit()..loadAyahs(surah.number),
        child: AyahSelectionScreen(surah: surah),
      ),
    );
  }

  // function fitur search
  List<SurahModel> _filtered(List<SurahModel> items) {
    final query = _searchController.text.toLowerCase();
    if (identical(_lastItems, items) && query == _lastQuery) {
      return _cachedFiltered;
    }
    _lastQuery = query;
    _lastItems = items;
    _cachedFiltered = query.isEmpty
        ? items
        : items.where((s) {
            return s.title.toLowerCase().contains(query) ||
                s.translation.toLowerCase().contains(query) ||
                s.arabicName.contains(query);
          }).toList();
    return _cachedFiltered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgPrimary,
      appBar: AppBar(
        backgroundColor: kBgPrimary,
        elevation: 0,
        title: const Text(
          'Surah Player',
          style: TextStyle(
            color: kWhite,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SurahSearchBar(controller: _searchController),
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state.inLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: kWhite38),
                    );
                  }

                  if (state.rc == rcError) {
                    return SurahErrorState(
                      message: state.errorMsg,
                      onRetry: () => context.read<HomeCubit>().loadSurah(),
                    );
                  }

                  final filtered = _filtered(state.items);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                        child: Text(
                          '${filtered.length} surahs',
                          style: const TextStyle(color: kWhite38, fontSize: 13),
                        ),
                      ),
                      Expanded(
                        child: filtered.isEmpty
                            ? const SurahEmptyState()
                            : ListView.builder(
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final surah = filtered[index];
                            return SurahTitle(
                              surah: surah,
                              isActive: state.currentSurah?.id == surah.id,
                              onTap: () => _openPlayer(surah),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            // MiniPlayer hanya rebuild saat currentSurah berubah
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (prev, curr) => prev.currentSurah != curr.currentSurah,
              builder: (context, state) {
                if (state.currentSurah == null) return const SizedBox.shrink();
                return MiniPlayer(
                  surah: state.currentSurah!,
                  onTap: () => _openPlayer(state.currentSurah!),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
