import 'package:firebase_flutter/services/database.dart';
import 'package:flutter/material.dart';
import '../model/Recipe.dart';
import 'add_recipe_page.dart';
import '../pages/recipe_details_page.dart';
import 'edit_recipe_page.dart';

class HomePage extends StatelessWidget {
  // Método para buscar a lista de receitas do banco de dados através do serviço DatabaseMethods
  Stream<List<Recipe>> getRecipes() {
    return DatabaseMethods().getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar com título do aplicativo
      appBar: AppBar(title: const Text("Receitas em Casa")),

      // Corpo da tela: utiliza StreamBuilder para buscar dados do Firebase em tempo real
      body: StreamBuilder<List<Recipe>>(
        stream: getRecipes(),
        builder: (context, snapshot) {
          // Exibe um círculo de carregamento enquanto os dados não estão prontos
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          // ListView para exibir cada receita em formato de cartão
          return ListView(
            children: snapshot.data!.map((recipe) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
                child: ListTile(
                  // Título da receita
                  title: Text(recipe.title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),

                  // Descrição da receita com limite de linhas e estilo de overflow
                  subtitle: Text(recipe.description,
                      maxLines: 2, overflow: TextOverflow.ellipsis),

                  // Evento ao clicar em uma receita: abre os detalhes da receita
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetail(recipe: recipe),
                      ),
                    );
                  },

                  // Botão de edição que leva à tela EditRecipePage para editar a receita
                  trailing: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.grey),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditRecipePage(recipe: recipe),
                        ),
                      );
                    },
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),

      // Botão flutuante para adicionar uma nova receita, abre a tela AddRecipePage
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddRecipePage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
