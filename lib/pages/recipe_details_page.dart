// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/service/database.dart';
import 'package:flutter/material.dart';
import '../model/Recipe.dart';

class RecipeDetail extends StatelessWidget {
  final Recipe recipe;

  RecipeDetail({required this.recipe});

  Future<void> deleteRecipe(String id) async {
    await DatabaseMethods().deleteRecipe(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(recipe.description, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            const Text("Ingredientes:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(recipe.ingredients),
            const SizedBox(height: 10),
            const Text("Instruções:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(recipe.instructions),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await deleteRecipe(recipe.id);
                Navigator.pop(context);
              },
              child: const Text("Deletar Receita"),
            ),
          ],
        ),
      ),
    );
  }
}
