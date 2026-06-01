import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_test/const/app_rc_const.dart';
import 'package:tech_test/logic/home_logic.dart';
import 'package:tech_test/model/surah_model.dart';

class HomeState {
  final bool inLoading;
  final String rc;
  final String errorMsg;
  final List<SurahModel> items;
  final SurahModel? currentSurah;
  final int? lastAyahNumber;

  HomeState({
    required this.inLoading,
    required this.rc,
    required this.errorMsg,
    required this.items,
    this.currentSurah,
    this.lastAyahNumber,
  });

  HomeState.init()
    : this(inLoading: false, rc: '', errorMsg: '', items: const []);

  HomeState.loading()
    : this(inLoading: true, rc: '', errorMsg: '', items: const []);

  HomeState.done({
    required String rc,
    required String errorMsg,
    required List<SurahModel> items,
  }) : this(inLoading: false, rc: rc, errorMsg: errorMsg, items: items);

  HomeState copyWith({SurahModel? currentSurah, int? lastAyahNumber}) => HomeState(
    inLoading: inLoading,
    rc: rc,
    errorMsg: errorMsg,
    items: items,
    currentSurah: currentSurah ?? this.currentSurah,
    lastAyahNumber: lastAyahNumber ?? this.lastAyahNumber,
  );
}

class HomeCubit extends Cubit<HomeState> {
  static const tag = 'HomeCubit';

  HomeCubit() : super(HomeState.init());

  // GET list semua surah dari api
  Future<void> loadSurah() async {
    debugPrint('[$tag] loadSurah: start');
    emit(HomeState.loading());
    try {
      final items = await HomeLogic.get().fetchSurahList();
      debugPrint('[$tag] loadSurah: done, items=${items.length}');
      emit(HomeState.done(rc: rcSuccess, errorMsg: '', items: items));
    } catch (e) {
      debugPrint('[$tag] loadSurah: error=$e');
      emit(HomeState.done(rc: rcError, errorMsg: e.toString(), items: []));
    }
  }

  // menyimpan surah yang sedang aktif untuk highlight di HomeScreen
  void selectSurah(SurahModel surah) {
    emit(state.copyWith(currentSurah: surah));
  }

  // menyimpan ayah terakhir yang diputar untuk highlight di AyahSelectionScreen
  void selectAyah(int ayahNumber) {
    emit(state.copyWith(lastAyahNumber: ayahNumber));
  }
}
