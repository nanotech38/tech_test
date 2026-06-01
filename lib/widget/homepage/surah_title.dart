import 'package:flutter/material.dart';
import '../../const/app_theme_const.dart';
import '../../model/surah_model.dart';

class SurahTitle extends StatelessWidget {
  final SurahModel surah;
  final bool isActive;
  final VoidCallback onTap;

  const SurahTitle({
    super.key,
    required this.surah,
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
          color: surah.color.withOpacity(0.25),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          isActive ? Icons.equalizer_rounded : Icons.music_note_rounded,
          color: isActive ? surah.color : kWhite38,
        ),
      ),
      title: Text(
        surah.title,
        style: TextStyle(
          color: isActive ? surah.color : kWhite,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          fontSize: 15,
        ),
      ),
      subtitle: Text(surah.translation, style: const TextStyle(color: kWhite38, fontSize: 13)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(surah.arabicName, style: const TextStyle(color: kWhite60, fontSize: 14)),
          const SizedBox(height: 2),
          Text(surah.duration, style: const TextStyle(color: kWhite24, fontSize: 11)),
        ],
      ),
    );
  }
}
