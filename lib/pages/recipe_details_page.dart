import 'package:firebase_flutter/service/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../model/Recipe.dart';

class RecipeDetail extends StatelessWidget {
  final Recipe recipe;

  RecipeDetail({required this.recipe});

  Future<void> deleteRecipe(String id) async {
    Fluttertoast.showToast(
      msg: "Receita excluída com sucesso!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    await DatabaseMethods().deleteRecipe(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              recipe.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).primaryColorDark,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              recipe.description,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const Divider(height: 30, thickness: 1),
            _buildSectionTitle(context, "Ingredientes"),
            _buildTextContent(recipe.ingredients),
            const Divider(height: 30, thickness: 1),
            _buildSectionTitle(context, "Instruções"),
            _buildTextContent(recipe.instructions),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () async {
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

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColorDark,
          ),
    );
  }

  Widget _buildTextContent(String content) {
    return Text(
      content,
      style: const TextStyle(fontSize: 16, height: 1.5),
      textAlign: TextAlign.left,
    );
  }
}
