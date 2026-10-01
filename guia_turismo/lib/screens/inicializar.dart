import 'package:flutter/material.dart';
import 'package:guia_turismo/screens/home_screen.dart';
import 'package:guia_turismo/themes/theme_controller.dart';
import 'package:provider/provider.dart';

class Inicializar extends StatelessWidget {
  const Inicializar({super.key});

  @override
  Widget build(BuildContext context) {
    //Consumer()
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeController()),
      ],
      child: Consumer<ThemeController>(
        builder: (context, controllerTheme, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: 'home',
          theme: controllerTheme.TemaClaro(),
          darkTheme: controllerTheme.TemaEscuro(),
          themeMode: controllerTheme.temaAtual,
          routes: {
            'home': (context) => HomeScreen(),
            // 'login' (context) => LoginScreen()
          },
          home: HomeScreen(),
        ),
      ),
    );
  }
}
