import 'package:flutter/material.dart';
import 'package:guia_turismo/themes/theme_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guia de Turismo"),
        actions: [
          Consumer<ThemeController>(
            builder: (context, controllerTheme, child) =>
            IconButton(
             onPressed: () => controllerTheme.alternarTema(),
             icon: Icon(controllerTheme.iconAtual)
            ),
          )
        ],
      ),
    );
  }
}
