import 'package:flutter/material.dart';
import 'package:guia/controllers/cadastro_controller.dart';
import 'package:provider/provider.dart';

import 'package:guia/controllers/auth_controller.dart';
import 'package:guia/controllers/camera_controller.dart';
import 'package:guia/controllers/lugares_controller.dart';
import 'package:guia/controllers/theme_controller.dart';

import 'package:guia/screens/home_screen.dart';
import 'package:guia/screens/lugares_screen.dart'; 
import 'package:guia/screens/cadastro_lugar.dart';
import 'package:guia/screens/login_screen.dart';
void main() {
  runApp(const Inicializar());
}

class Inicializar extends StatelessWidget {
  const Inicializar({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LugaresController()),
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => CameraController()),
        ChangeNotifierProvider(create: (_) => ThemeController()),
        ChangeNotifierProvider(create: (_) => CadastroController())
        ],
      child: Consumer<ThemeController>(
        builder: (context, themeController, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeController.temaClaro(),
            darkTheme: themeController.temaEscuro(),
            themeMode: themeController.temaAtual, 
            
            initialRoute: 'home', 
            routes: {
              'home': (context) => const HomeScreen(),
              'lugares': (context) => const LugaresScreen(),
              'cadastro': (context) => const CadastroLugar(),
              'login': (context) => const LoginScreen(),

              }, 
          );
        },
      ),
    );
  }
}