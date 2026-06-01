import 'package:flutter/material.dart';
import '../../const/app_theme_const.dart';
import '../../model/ayah_model.dart';

class AyahTitle extends StatelessWidget {
  final AyahModel ayah;
  final bool isActive;
  final VoidCallback onTap;

  const AyahTitle({
    super.key,
    required this.ayah,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: isActive ? kWhite12 : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nomor ayah
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isActive ? kWhite60 : kWhite24,
                  ),
                  shape: BoxShape.circle,
                  color: isActive ? kWhite12 : Colors.transparent,
                ),
                alignment: Alignment.center,
                child: Text(
                  '${ayah.numberInSurah}',
                  style: TextStyle(
                    color: isActive ? kWhite : kWhite60,
                    fontSize: 13,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Teks ayah
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  ayah.text,
                  style: TextStyle(
                    color: isActive ? kWhite : kWhite60,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Icon(
                isActive
                    ? Icons.pause_circle_outline_rounded
                    : Icons.play_circle_outline_rounded,
                color: isActive ? kWhite60 : kWhite24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
