import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_test/const/app_rc_const.dart';
import '../logic/home_logic.dart';
import '../model/surah_model.dart';

class HomeState {
  final bool inLoading;
  final String rc;
  final String errorMsg;
  final List<SurahModel> items;
  final SurahModel? currentSurah;

  HomeState({
    required this.inLoading,
    required this.rc,
    required this.errorMsg,
    required this.items,
    this.currentSurah,
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

  HomeState copyWith({SurahModel? currentSurah}) => HomeState(
        inLoading: inLoading,
        rc: rc,
        errorMsg: errorMsg,
        items: items,
        currentSurah: currentSurah,
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

  void selectSurah(SurahModel surah) {
    emit(state.copyWith(currentSurah: surah));
  }
}
