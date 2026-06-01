import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/surah_model.dart';

class HomeLogic {
  static const tag = 'HomeLogic';

  static final HomeLogic _instance = HomeLogic._();
  static HomeLogic get() => _instance;

  HomeLogic._();

  Future<List<SurahModel>> fetchSurahList() async {
    final response = await http.get(
      Uri.parse('https://api.alquran.cloud/v1/surah'),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final List data = json['data'];
      return data.map((e) => SurahModel.fromJson(e)).toList();
    }
    throw Exception('Failed to load: ${response.statusCode}');
  }
}
