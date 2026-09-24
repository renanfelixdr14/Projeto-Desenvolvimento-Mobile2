import 'package:flutter/material.dart';
import 'package:lista_produtos/models/produto_model.dart';
import 'package:lista_produtos/services/produto_banco.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProdutoModel> _listarProdutos = [];

  @override
  void initState() {
    super.initState();
    _carregarLista();
  }

  void _carregarLista() async {
    final produtos = await ProdutoBanco().listarProdutos();
    setState(() {
      _listarProdutos = produtos;
    });
  }

  void abrirFormulario(ProdutoModel? produto) {
    bool isEditing = produto != null;

    // Inicializa os controllers com os dados existentes ou vazios
    final nomeController = TextEditingController(text: produto?.nome ?? '');
    final categoriaController = TextEditingController(text: produto?.categoria ?? '');
    final precoController = TextEditingController(text: produto?.preco.toString() ?? '');
    final estoqueController = TextEditingController(text: produto?.estoque.toString() ?? '');
    final caracteristicaController = TextEditingController(text: produto?.caracteristica ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditing ? "Editar Produto" : "Cadastrar Produto"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nomeController,
                  decoration: const InputDecoration(labelText: "Nome"),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: categoriaController,
                  decoration: const InputDecoration(labelText: "Categoria"),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: precoController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: "Preço"),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: estoqueController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Estoque"),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: caracteristicaController,
                  decoration: const InputDecoration(labelText: "Característica"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                // Cria ou atualiza o objeto com os dados digitados nos campos
                final novoProduto = ProdutoModel(
                  id: produto?.id, // Mantém o ID se for edição, null se for novo
                  nome: nomeController.text,
                  categoria: categoriaController.text,
                  preco: double.tryParse(precoController.text) ?? 0.0,
                  estoque: int.tryParse(estoqueController.text) ?? 0,
                  caracteristica: caracteristicaController.text,
                );
                _salvarDados(novoProduto, isEditing);
              },
              child: const Text("Salvar"),
            ),
          ],
        );
      },
    );
  }

  void _salvarDados(ProdutoModel produto, bool isEditing) async {
    bool salvou = false;
    if (!isEditing) {
      salvou = await ProdutoBanco().inserirProduto(produto);
    } else {
      salvou = await ProdutoBanco().atualizarProduto(produto);
    }

    if (salvou) {
      // Fecha o modal do formulário
      Navigator.of(context).pop();

      // Recarrega a lista
      _carregarLista();
//escondido
      // Exibe a mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(!isEditing ? "Produto salvo com sucesso!" : "Produto atualizado com sucesso!"),
        ),
      );
    }
  }

  void _abrirModalExclusao(ProdutoModel produto) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Excluir Produto"),
          content: Text("Deseja realmente excluir o produto ${produto.nome}?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                deletarProduto(produto.id!);
                Navigator.pop(context);
              },
              child: const Text("Excluir", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void deletarProduto(int id) async {
    bool deletou = await ProdutoBanco().deletarProduto(id);
    if (deletou) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Produto deletado com sucesso!")),
      );
      _carregarLista();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Produtos"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: _listarProdutos.isEmpty
          ? const Center(child: Text("Nenhum produto cadastrado."))
          : ListView.builder(
              itemCount: _listarProdutos.length,
              itemBuilder: (context, index) {
                final item = _listarProdutos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(item.nome),
                    subtitle: Text('${item.categoria} - R\$ ${item.preco.toStringAsFixed(2)}'),
                    leading: const CircleAvatar(child: Icon(Icons.shopping_bag)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => abrirFormulario(item),
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () => _abrirModalExclusao(item),
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          abrirFormulario(null); // Passa null para criar um novo produto
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}