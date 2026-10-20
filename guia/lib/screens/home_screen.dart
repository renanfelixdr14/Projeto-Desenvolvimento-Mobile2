import 'package:flutter/material.dart';
import 'package:guia/widgets/theme_widget.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Página Inicial"),
        actions: const [
          ThemeWidget(),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.place,
              size: 100,
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 20),
            const Text(
              "Bem-vindo ao Guia!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, 'lugares');
                },
                icon: const Icon(Icons.list),
                label: const Text(
                  "Ver Lugares",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, 'cadastro');
                },
                icon: const Icon(Icons.add_location_alt),
                label: const Text(
                  "Cadastrar Lugar",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}