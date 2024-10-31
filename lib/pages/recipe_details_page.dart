import 'package:firebase_flutter/services/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../model/Recipe.dart';

// Tela de detalhes de uma receita, recebendo um objeto Recipe como parâmetro
class RecipeDetail extends StatelessWidget {
  final Recipe recipe;

  RecipeDetail({required this.recipe});

  // Função para excluir a receita do banco de dados
  Future<void> deleteRecipe(String id) async {
    // Mostra uma mensagem de sucesso quando a receita é excluída
    Fluttertoast.showToast(
      msg: "Receita excluída com sucesso!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    // Chama o método de exclusão no banco de dados
    await DatabaseMethods().deleteRecipe(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Define o título da AppBar como o título da receita
        title: Text(recipe.title),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Exibe o título da receita
            Text(
              recipe.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).primaryColorDark,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Exibe a descrição da receita
            Text(
              recipe.description,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const Divider(height: 30, thickness: 1),

            // Exibe o título "Ingredientes" e a lista de ingredientes
            _buildSectionTitle(context, "Ingredientes"),
            _buildTextContent(recipe.ingredients),
            const Divider(height: 30, thickness: 1),

            // Exibe o título "Instruções" e as instruções da receita
            _buildSectionTitle(context, "Instruções"),
            _buildTextContent(recipe.instructions),
            const SizedBox(height: 30),

            // Botão para excluir a receita
            ElevatedButton.icon(
              onPressed: () async {
                // Chama a função de exclusão e volta para a tela anterior
                await deleteRecipe(recipe.id);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.delete),
              label: const Text("Deletar Receita"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para criar um título de seção com estilo específico
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColorDark,
          ),
    );
  }

  // Método para exibir conteúdo de texto, como ingredientes ou instruções
  Widget _buildTextContent(String content) {
    return Text(
      content,
      style: const TextStyle(fontSize: 16, height: 1.5),
      textAlign: TextAlign.left,
    );
  }
}
