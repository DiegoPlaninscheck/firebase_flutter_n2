// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/service/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';
// import '../model/Recipe.dart';

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
            msg: "This is Center Short Toast",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Adicionar Receita")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Título"),
                onChanged: (value) => title = value,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Descrição"),
                onChanged: (value) => description = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Ingredientes"),
                onChanged: (value) => ingredients = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Instruções"),
                onChanged: (value) => instructions = value,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await addRecipe();
                    Navigator.pop(context);
                  }
                },
                child: const Text("Adicionar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
