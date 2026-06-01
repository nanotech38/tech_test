import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_test/const/app_rc_const.dart';
import '../logic/ayah_logic.dart';
import '../model/ayah_model.dart';

class AyahState {
  final bool inLoading;
  final String rc;
  final String errorMsg;
  final List<AyahModel> items;

  AyahState({
    required this.inLoading,
    required this.rc,
    required this.errorMsg,
    required this.items,
  });

  AyahState.init()
    : this(inLoading: false, rc: '', errorMsg: '', items: const []);

  AyahState.loading()
    : this(inLoading: true, rc: '', errorMsg: '', items: const []);

  AyahState.done({
    required String rc,
    required String errorMsg,
    required List<AyahModel> items,
  }) : this(inLoading: false, rc: rc, errorMsg: errorMsg, items: items);
}

class AyahCubit extends Cubit<AyahState> {
  static const tag = 'AyahCubit';

  AyahCubit() : super(AyahState.init());

  // GET list ayah berdasarkan nomor surah
  Future<void> loadAyahs(int surahNumber) async {
    debugPrint('[$tag] loadAyahs: surah=$surahNumber');
    emit(AyahState.loading());
    try {
      final items = await AyahLogic.get().fetchAyahList(surahNumber);
      debugPrint('[$tag] loadAyahs: done, items=${items.length}');
      emit(AyahState.done(rc: rcSuccess, errorMsg: '', items: items));
    } catch (e) {
      debugPrint('[$tag] loadAyahs: error=$e');
      emit(AyahState.done(rc: rcError, errorMsg: e.toString(), items: []));
    }
  }
}
