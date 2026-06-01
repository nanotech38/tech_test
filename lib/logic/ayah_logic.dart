import 'package:flutter/material.dart';
import '../const/app_trx_const.dart';
import '../model/ayah_model.dart';
import '../services/apps_network_service.dart';

class AyahLogic {
  static const tag = 'AyahLogic';

  static final AyahLogic _instance = AyahLogic._();
  static AyahLogic get() => _instance;

  AyahLogic._();

  // cache hasil fetch per surahNumber agar tidak fetch ulang surah yang sama
  final Map<int, List<AyahModel>> _cache = {};

  // GET list ayah berdasarkan nomor surah
  Future<List<AyahModel>> fetchAyahList(int surahNumber) async {
    if (_cache.containsKey(surahNumber)) {
      debugPrint('[$tag] fetchAyahList: cache hit surah=$surahNumber');
      return _cache[surahNumber]!;
    }
    debugPrint('[$tag] fetchAyahList: surah=$surahNumber');
    try {
      final json = await AppsNetworkService.get().fetch(kSurahDetail(surahNumber));
      final List ayahs = json['data']['ayahs'];
      debugPrint('[$tag] fetchAyahList: total=${ayahs.length}');
      final result = ayahs.map((e) => AyahModel.fromJson(e)).toList();
      _cache[surahNumber] = result;
      return result;
    } catch (e, s) {
      debugPrint('[$tag] fetchAyahList: error=$e');
      debugPrint('[$tag] fetchAyahList: stack=$s');
      rethrow;
    }
  }
}
