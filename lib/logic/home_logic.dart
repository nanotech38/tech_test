import 'package:flutter/material.dart';
import '../const/app_trx_const.dart';
import '../model/surah_model.dart';
import '../services/apps_network_service.dart';

class HomeLogic {
  static const tag = 'HomeLogic';

  static final HomeLogic _instance = HomeLogic._();
  static HomeLogic get() => _instance;

  HomeLogic._();

  // GET list semua surah dari api dan taruh di model
  Future<List<SurahModel>> fetchSurahList() async {
    debugPrint('[$tag] fetchSurahList: start');
    try {
      final json = await AppsNetworkService.get().fetch(kSurah);
      final List data = json['data'];
      debugPrint('[$tag] fetchSurahList: total=${data.length}');
      return data
          .asMap()
          .entries
          .map((e) => SurahModel.fromJson(e.value, e.key))
          .toList();
    } catch (e, s) {
      debugPrint('[$tag] fetchSurahList: error=$e');
      debugPrint('[$tag] fetchSurahList: stack=$s');
      rethrow;
    }
  }
}
