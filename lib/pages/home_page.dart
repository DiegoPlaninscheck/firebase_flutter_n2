import 'package:firebase_flutter/service/database.dart';
import 'package:flutter/material.dart';
import '../model/Recipe.dart';
import 'add_recipe_page.dart';
import '../pages/recipe_details_page.dart';
import 'edit_recipe_page.dart'; // Nova página para edição

class HomePage extends StatelessWidget {
  Stream<List<Recipe>> getRecipes() {
    return DatabaseMethods().getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Receitas")),
      body: StreamBuilder<List<Recipe>>(
        stream: getRecipes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.map((recipe) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
                child: ListTile(
                  title: Text(recipe.title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(recipe.description,
                      maxLines: 2, overflow: TextOverflow.ellipsis),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetail(recipe: recipe),
                      ),
                    );
                  },
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
