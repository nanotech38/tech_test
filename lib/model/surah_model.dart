import 'package:flutter/material.dart';

class SurahModel {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final int numberOfAyahs;
  final String revelationType;
  final Color color;

  // getter untuk UI
  String get title => englishName;
  String get arabicName => name;
  String get translation => englishNameTranslation;
  String get duration => '$numberOfAyahs ayat';

  const SurahModel({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.numberOfAyahs,
    required this.revelationType,
    required this.color,
  });

  static const _palette = [
    Colors.purple,
    Colors.orange,
    Colors.indigo,
    Colors.teal,
    Colors.green,
    Colors.red,
    Colors.deepPurple,
    Colors.amber,
    Colors.cyan,
    Colors.pink,
    Colors.blue,
    Colors.lime,
  ];

  factory SurahModel.fromJson(Map<String, dynamic> json, int index) {
    return SurahModel(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      englishNameTranslation: json['englishNameTranslation'],
      numberOfAyahs: json['numberOfAyahs'],
      revelationType: json['revelationType'],
      color: _palette[index % _palette.length],
    );
  }
}
