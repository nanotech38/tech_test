import 'package:flutter/material.dart';
import '../const/app_trx_const.dart';
import '../model/ayah_model.dart';
import '../services/apps_network_service.dart';

class AyahLogic {
  static const tag = 'AyahLogic';

  static final AyahLogic _instance = AyahLogic._();
  static AyahLogic get() => _instance;

  AyahLogic._();

  // GET list ayah berdasarkan nomor surah
  Future<List<AyahModel>> fetchAyahList(int surahNumber) async {
    debugPrint('[$tag] fetchAyahList: surah=$surahNumber');
    try {
      final json = await AppsNetworkService.get().fetch(kSurahDetail(surahNumber));
      final List ayahs = json['data']['ayahs'];
      debugPrint('[$tag] fetchAyahList: total=${ayahs.length}');
      return ayahs.map((e) => AyahModel.fromJson(e)).toList();
    } catch (e, s) {
      debugPrint('[$tag] fetchAyahList: error=$e');
      debugPrint('[$tag] fetchAyahList: stack=$s');
      rethrow;
    }
  }
}
