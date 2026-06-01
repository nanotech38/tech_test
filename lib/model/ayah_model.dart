class AyahModel {
  final int number;
  final int numberInSurah;
  final String text;

  const AyahModel({
    required this.number,
    required this.numberInSurah,
    required this.text,
  });

  String get audioUrl =>
      'https://cdn.islamic.network/quran/audio/128/ar.alafasy/$number.mp3';

  factory AyahModel.fromJson(Map<String, dynamic> json) {
    return AyahModel(
      number: json['number'],
      numberInSurah: json['numberInSurah'],
      text: json['text'],
    );
  }
}
