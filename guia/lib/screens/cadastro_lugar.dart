import 'package:flutter/material.dart';
import 'package:guia/controllers/camera_controller.dart';
import 'package:provider/provider.dart';

class CadastroLugar extends StatefulWidget {
  const new({super.key});

  @override
  State<CadastroLugar> createState() => _CadastroLugarState();
}

class _CadastroLugarState extends State<CadastroLugar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CameraController>(
        builder: (context, cameraControle, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  //primeiro widget
                  height: 300,
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
                  child: IconButton(
                    onPressed: () => abrirModal(cameraControle, context),
                    icon: Icon(Icons.camera_alt)
                  )
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

DecorationImage exibirImagem (CameraController cameraControle) {
  if(cameraControle.imagemSelecionada == null) {
    return DecorationImage(image: NetworkImage('https://placehold.jp/150x150.png'));
  } else {
    return DecorationImage(image: FileImage(cameraControle.imagemSelecionada!),
    fit: BoxFit.cover
    );
  }
}

void abrirModal(CameraController cameraControle, context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => 
    SafeArea(
      bottom: true,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          ListTile(
            leading: Icon(Icons.camera),
            onTap: () {
              cameraControle.abrirCamera();
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_album),
            onTap: () {
              cameraControle.abrirGaleria();
              Navigator.pop(context);
            },
          )
        ],
      )
      )
    );
}