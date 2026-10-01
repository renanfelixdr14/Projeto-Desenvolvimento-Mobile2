import 'package:flutter/material.dart';
import 'package:guia_turismo/themes/theme_widgets.dart';

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
      //primarySwatch: Colors.green,
      useMaterial3: true,
      colorScheme: cor,
      appBarTheme: defineAppBar(cor),
      bottomNavigationBarTheme: defineNavegacaoBase(cor),
      elevatedButtonTheme: defineElevatedButton(cor),
      iconButtonTheme: IconButtonThemeData(),
      cardTheme: CardThemeData()
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
