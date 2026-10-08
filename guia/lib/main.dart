import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:guia/controllers/lugares_controller.dart';
import 'package:guia/screens/lugares_screen.dart'; 

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
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LugaresScreen(), 
      ),
    );
  }
}