import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  ThemeMode _temaAtual = ThemeMode.light;
  ThemeMode get temaAtual => _temaAtual;

  IconData get iconAtual =>
      _temaAtual == ThemeMode.light ? Icons.light_mode : Icons.dark_mode;

  static ThemeData _mudarTema(Brightness brilho) {
    final cor = ColorScheme.fromSeed(
      seedColor: Colors.green,
      brightness: brilho,
    );

    return ThemeData(
      primarySwatch: Colors.green,
      colorScheme: cor,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: cor.primary,
        foregroundColor: cor.onPrimary,
        elevation: 4,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: cor.primary,
        elevation: 4,
      ),
    );
  }

  ThemeData TemaClaro() => _mudarTema(Brightness.light);
  ThemeData TemaEscuro() => _mudarTema(Brightness.dark);

  void alternarTema() {
    _temaAtual = _temaAtual == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }
  
}
