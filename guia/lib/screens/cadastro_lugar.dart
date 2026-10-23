import 'package:flutter/material.dart';
import 'package:guia/controllers/camera_controller.dart';
import 'package:guia/controllers/cadastro_controller.dart';
import 'package:provider/provider.dart';

class CadastroLugar extends StatelessWidget {
  const CadastroLugar({super.key});

  @override
  Widget build(BuildContext context) {
    final cadastroController = Provider.of<CadastroController>(context);
    final cameraControle = Provider.of<CameraController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Novo Lugar'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(16),
                      image: exibirImagem(cameraControle),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.8),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () => abrirModal(cameraControle, context),
                        icon: const Icon(Icons.camera_alt, color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: cadastroController.nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do Lugar',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.place),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: cadastroController.descricaoController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
              ),
            ),

            const SizedBox(height: 16),
            
            TextField(
              controller: cadastroController.categoriaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'ID da Categoria',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: cadastroController.latitudeController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Latitude',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: cadastroController.longitudeController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Longitude',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () => cadastroController.salvarLugar(context), 
                icon: const Icon(Icons.save),
                label: const Text('Salvar Lugar', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


DecorationImage exibirImagem(CameraController cameraControle) {
  if (cameraControle.imagemSelecionada == null) { 
    return const DecorationImage(
      image: NetworkImage('https://placehold.jp/150x150.png'),
    );
  } else {
    return DecorationImage(
      image: FileImage(cameraControle.imagemSelecionada!),
      fit: BoxFit.cover,
    );
  }
}

void abrirModal(CameraController cameraControle, BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => SafeArea(
      bottom: true,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          ListTile(
            leading: const Icon(Icons.camera),
            title: const Text('Tirar Foto'),
            onTap: () {
              cameraControle.abrirCamera();
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_album),
            title: const Text('Escolher da Galeria'),
            onTap: () {
              cameraControle.abrirGaleria();
              Navigator.pop(context);
            },
          )
        ],
      ),
    ),
  );
}