import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:guia/controllers/theme_controller.dart';

AppBarTheme defineAppBar(cor) {
  return AppBarTheme(
    centerTitle: true,
    backgroundColor: cor.primary,
    foregroundColor: cor.onPrimary, //cor de texto
    elevation: 4, //Box shadow
  );
}
 
BottomNavigationBarThemeData defineNavegacaoBase(cor) {
  return BottomNavigationBarThemeData(
    backgroundColor: cor.primary,
    elevation: 4,
  );
}
 
ElevatedButtonThemeData defineBotaoElevated(cor) {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
  );
}

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context, themeController, child) {
        return IconButton(
          icon: Icon(themeController.iconeAtual),
          onPressed: () {
            themeController.alternarTema();
          },
        );
      },
    );
  }
}