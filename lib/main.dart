import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/home_cubit.dart';
import 'screen/home_screen.dart';
import 'services/navigation_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Surah Player',
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.get().navigatorKey,
      home: BlocProvider(
        create: (_) => HomeCubit()..loadSurah(),
        child: const HomeScreen(),
      ),
    );
  }
}
