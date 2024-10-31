import 'package:firebase_flutter/service/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class AddRecipePage extends StatefulWidget {
  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  String ingredients = '';
  String instructions = '';

  Future<void> addRecipe() async {
    String id = randomAlphaNumeric(10);
    Map<String, dynamic> recipe = {
      "id": id,
      "title": title,
      "description": description,
      "ingredients": ingredients,
      "instructions": instructions,
    };
    await DatabaseMethods().addRecipe(recipe, id).then(
      (value) {
        Fluttertoast.showToast(
          msg: "Receita adicionada com sucesso!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Receita"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                "Adicione uma nova receita",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: "Título",
                onChanged: (value) => title = value,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              _buildTextField(
                label: "Descrição",
                onChanged: (value) => description = value,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
                maxLines: 5,
              ),
              _buildTextField(
                label: "Ingredientes",
                onChanged: (value) => ingredients = value,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
                maxLines: 5,
              ),
              _buildTextField(
                label: "Instruções",
                onChanged: (value) => instructions = value,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
                maxLines: 5,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await addRecipe();
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text("Adicionar Receita"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required Function(String) onChanged,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Theme.of(context).primaryColor),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onChanged: onChanged,
        maxLines: maxLines,
        validator: validator,
      ),
    );
  }
}
