import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/home_logic.dart';
import '../model/song.dart';

class HomeState {
  final bool inLoading;
  final String rc;
  final String errorMsg;
  final List<Song> items;

  HomeState({
    required this.inLoading,
    required this.rc,
    required this.errorMsg,
    required this.items,
  });

  HomeState.init()
      : this(inLoading: false, rc: '', errorMsg: '', items: const []);

  HomeState.loading()
      : this(inLoading: true, rc: '', errorMsg: '', items: const []);

  HomeState.done({
    required String rc,
    required String errorMsg,
    required List<Song> items,
  }) : this(inLoading: false, rc: rc, errorMsg: errorMsg, items: items);
}

class HomeCubit extends Cubit<HomeState> {
  static const tag = 'HomeCubit';

  HomeCubit() : super(HomeState.init());

  void loadSongs() async {
    emit(HomeState.loading());
    try {
      final surahs = await HomeLogic.get().fetchSurahList();
      final items = surahs
          .asMap()
          .entries
          .map((e) => Song.fromSurah(e.value, e.key))
          .toList();
      emit(HomeState.done(rc: '0', errorMsg: '', items: items));
    } catch (e) {
      emit(HomeState.done(rc: 'error', errorMsg: e.toString(), items: []));
    }
  }
}
