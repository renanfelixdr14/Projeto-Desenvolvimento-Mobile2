import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:guia/controllers/lugares_controller.dart'; // Seu import

class LugaresScreen extends StatefulWidget {
  const LugaresScreen({super.key});

  @override
  State<LugaresScreen> createState() => _LugaresScreenState();
}

class _LugaresScreenState extends State<LugaresScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lugares para visitar"),
      ),
      body: Consumer<LugaresController>(
        builder: (context, lugaresController, child) {
          
          if(lugaresController.carregando){
            return const Center(child: CircularProgressIndicator());
          }
          if(lugaresController.erro != '') {
            return Center(child: Text(lugaresController.erro));
          }
          if(lugaresController.lugares.isEmpty) {
            return const Center(child: Text("Nenhum lugar encontrado!"));
          }

          return ListView.builder(
            itemCount: lugaresController.lugares.length,
            itemBuilder: (context, index) {
              final lugar = lugaresController.lugares[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
                elevation: 4,
                child: ListTile(
                  onTap: (){},
                  title: Text(lugar.nome),
                  subtitle: Text(lugar.descricao.toString()),
                  leading: const CircleAvatar(child: Icon(Icons.place)),
                  trailing: IconButton(onPressed: (){}, icon: const Icon(Icons.favorite)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}