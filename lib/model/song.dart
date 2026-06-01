import 'package:flutter/material.dart';
import '../model/surah_model.dart';

class Song {
  final String id;
  final String title;
  final String artist;
  final String duration;
  final Color color;

  const Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.duration,
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

  factory Song.fromSurah(SurahModel surah, int index) {
    return Song(
      id: surah.number.toString(),
      title: surah.englishName,
      artist: surah.englishNameTranslation,
      duration: '${surah.numberOfAyahs} ayat',
      color: _palette[index % _palette.length],
    );
  }
}

final List<Song> mockSongs = [ // hardcoded
  Song(id: '1', title: 'Bohemian Rhapsody', artist: 'Queen', duration: '5:55', color: Colors.purple),
  Song(id: '2', title: 'Hotel California', artist: 'Eagles', duration: '6:30', color: Colors.orange),
  Song(id: '3', title: 'Stairway to Heaven', artist: 'Led Zeppelin', duration: '8:02', color: Colors.indigo),
  Song(id: '4', title: 'Imagine', artist: 'John Lennon', duration: '3:07', color: Colors.teal),
  Song(id: '5', title: 'Smells Like Teen Spirit', artist: 'Nirvana', duration: '5:01', color: Colors.green),
  Song(id: '6', title: 'Like a Rolling Stone', artist: 'Bob Dylan', duration: '6:13', color: Colors.red),
  Song(id: '7', title: 'Purple Rain', artist: 'Prince', duration: '8:41', color: Colors.deepPurple),
  Song(id: '8', title: 'Johnny B. Goode', artist: 'Chuck Berry', duration: '2:42', color: Colors.amber),
  Song(id: '9', title: 'What\'s Going On', artist: 'Marvin Gaye', duration: '3:53', color: Colors.cyan),
  Song(id: '10', title: 'Respect', artist: 'Aretha Franklin', duration: '2:27', color: Colors.pink),
];
