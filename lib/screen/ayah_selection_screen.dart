import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_test/bloc/ayah_cubit.dart';
import 'package:tech_test/const/app_rc_const.dart';
import 'package:tech_test/const/app_theme_const.dart';
import 'package:tech_test/model/surah_model.dart';
import 'package:tech_test/services/navigation_service.dart';
import 'package:tech_test/widget/ayah/ayah_title.dart';
import 'player_screen.dart';

class AyahSelectionScreen extends StatelessWidget {
  final SurahModel surah;

  const AyahSelectionScreen({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgPrimary,
      appBar: AppBar(
        backgroundColor: kBgPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: kWhite,
            size: 32,
          ),
          onPressed: () => NavigationService.get().pop(),
        ),
        title: Column(
          children: [
            Text(
              surah.title,
              style: const TextStyle(color: kWhite, fontSize: 16),
            ),
            Text(
              surah.translation,
              style: const TextStyle(color: kWhite54, fontSize: 12),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<AyahCubit, AyahState>(
        builder: (context, state) {
          if (state.inLoading) {
            return const Center(
              child: CircularProgressIndicator(color: kWhite38),
            );
          }

          if (state.rc == rcError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.wifi_off_rounded, color: kWhite24, size: 64),
                  const SizedBox(height: 16),
                  const Text(
                    'Failed to load ayahs',
                    style: TextStyle(color: kWhite54),
                  ),
                  const SizedBox(height: 16),
                  TextButton.icon(
                    // load ulang kalau gagal
                    onPressed: () =>
                        context.read<AyahCubit>().loadAyahs(surah.number),
                    icon: const Icon(Icons.refresh_rounded, color: kWhite54),
                    label: const Text(
                      'Retry',
                      style: TextStyle(color: kWhite54),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            itemCount: state.items.length,
            separatorBuilder: (_, _) =>
                const Divider(color: kWhite12, height: 1),
            itemBuilder: (context, index) {
              final ayah = state.items[index];
              return AyahTitle(
                ayah: ayah,
                onTap: () => NavigationService.get().push(
                  PlayerScreen(
                    surah: surah,
                    ayahs: state.items,
                    initialIndex: index,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
