import 'package:flutter/material.dart';
import 'package:guia/services/session_service.dart';
import 'package:guia/widgets/theme_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _nomeUsuario = '';
  bool _estaLogado = false;

  @override
  void initState() {
    super.initState();
    _verificarSessao();
  }
  Future<void> _verificarSessao() async {
    final token = await SessionService().pegarToken();
    final nome = await SessionService().pegarNome();
    setState(() {
      _estaLogado = token != null && token.isNotEmpty;
      _nomeUsuario = nome;
    });
  }

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.place,
                size: 80,
                color: Colors.blueAccent,
              ),
              const SizedBox(height: 10),
              Text(
                _estaLogado ? "Olá, $_nomeUsuario!" : "Bem-vindo ao Guia!",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, 'lugares');
                  },
                  icon: const Icon(Icons.list),
                  label: const Text("Ver Lugares", style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_estaLogado) {
                      Navigator.pushNamed(context, 'cadastro')
                          .then((_) => _verificarSessao());
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Precisa de fazer login para cadastrar um lugar!'),
                        ),
                      );
                      Navigator.pushNamed(context, 'login')
                          .then((_) => _verificarSessao());
                    }
                  },
                  icon: const Icon(Icons.add_location_alt),
                  label: const Text("Cadastrar Lugar", style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 250,
                height: 50,
                child: _estaLogado
                    ? OutlinedButton.icon(
                        onPressed: () async {
                          await SessionService().logout();
                          _verificarSessao(); 
                        },
                        icon: const Icon(Icons.logout, color: Colors.red),
                        label: const Text(
                          "Sair",
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      )
                    : ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, 'login')
                              .then((_) => _verificarSessao());
                        },
                        icon: const Icon(Icons.login),
                        label: const Text("Fazer Login", style: TextStyle(fontSize: 18)),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}