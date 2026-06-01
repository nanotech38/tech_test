import 'package:flutter/material.dart';
import '../../const/app_theme_const.dart';
import '../../model/ayah_model.dart';

class AyahTitle extends StatelessWidget {
  final AyahModel ayah;
  final VoidCallback onTap;

  const AyahTitle({super.key, required this.ayah, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nomor ayah — dibungkus agar center terhadap satu baris teks
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  border: Border.all(color: kWhite24),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '${ayah.numberInSurah}',
                  style: const TextStyle(color: kWhite60, fontSize: 13),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Teks ayah
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Text(
                  ayah.text,
                  style: const TextStyle(color: kWhite, fontSize: 18),
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Icon(Icons.play_circle_outline_rounded, color: kWhite24),
            ),
          ],
        ),
      ),
    );
  }
}
