import 'package:flutter/material.dart';
import '../../const/app_theme_const.dart';
import '../../model/surah_model.dart';

class MiniPlayer extends StatelessWidget {
  final SurahModel surah;
  final VoidCallback onTap;

  const MiniPlayer({super.key, required this.surah, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: kBgSecondary,
          border: Border(top: BorderSide(color: kWhite12)),
        ),
        padding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: surah.color.withOpacity(0.25),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.music_note_rounded, color: surah.color, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    surah.title,
                    style: const TextStyle(
                      color: kWhite,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(surah.translation, style: const TextStyle(color: kWhite38, fontSize: 12)),
                ],
              ),
            ),
            const IconButton(
              icon: Icon(Icons.pause_circle_filled_rounded, color: kWhite, size: 38),
              onPressed: null,
            ),
          ],
        ),
      ),
    );
  }
}
