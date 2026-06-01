import 'package:flutter/material.dart';
import '../../const/app_theme_const.dart';

class SurahSearchBar extends StatelessWidget {
  final TextEditingController controller;

  const SurahSearchBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: kWhite),
        decoration: InputDecoration(
          hintText: 'Search Surah',
          hintStyle: const TextStyle(color: kWhite38),
          prefixIcon: const Icon(Icons.search, color: kWhite38),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: kWhite38),
                  onPressed: controller.clear,
                )
              : null,
          filled: true,
          fillColor: kBgSecondary,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
