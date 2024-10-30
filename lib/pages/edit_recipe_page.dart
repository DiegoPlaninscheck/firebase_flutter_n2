import 'package:firebase_flutter/service/database.dart';
import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/Recipe.dart';

class EditRecipePage extends StatefulWidget {
  final Recipe recipe;

  const EditRecipePage({Key? key, required this.recipe}) : super(key: key);

  @override
  _EditRecipePageState createState() => _EditRecipePageState();
}

class _EditRecipePageState extends State<EditRecipePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _ingredientsController;
  late TextEditingController _instructionsController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.recipe.title);
    _descriptionController =
        TextEditingController(text: widget.recipe.description);
    _ingredientsController =
        TextEditingController(text: widget.recipe.ingredients);
    _instructionsController =
        TextEditingController(text: widget.recipe.instructions);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _ingredientsController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  Future<void> _updateRecipe() async {
    if (_formKey.currentState!.validate()) {
      try {
        // await FirebaseFirestore.instance
        //     .collection('recipe')
        //     .doc(widget.recipe.id)
        //     .update({
        //   'title': _titleController.text,
        //   'description': _descriptionController.text,
        //   'ingredients': _ingredientsController.text,
        //   'instructions': _instructionsController.text
        // });

        await DatabaseMethods().updateRecipe(widget.recipe.id, {
          'title': _titleController.text,
          'description': _descriptionController.text,
          'ingredients': _ingredientsController.text,
          'instructions': _instructionsController.text
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Receita atualizada com sucesso!')),
        );
        Navigator.pop(context); // Volta para a página anterior
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao atualizar a receita: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Receita')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o título';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ingredientsController,
                decoration: const InputDecoration(labelText: 'Ingredientes'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira os ingredientes';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              const SizedBox(height: 16),
              TextFormField(
                controller: _instructionsController,
                decoration: const InputDecoration(labelText: 'Instruções'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira as instruções ';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _updateRecipe,
                child: const Text('Salvar Alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
