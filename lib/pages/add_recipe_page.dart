import 'package:firebase_flutter/services/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

// Tela de adicionar receita, que utiliza um StatefulWidget para manter o estado do formulário
class AddRecipePage extends StatefulWidget {
  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  // Chave para validação do formulário
  final _formKey = GlobalKey<FormState>();
  // Variáveis para armazenar os dados da receita
  String title = '';
  String description = '';
  String ingredients = '';
  String instructions = '';

  // Método para adicionar receita ao Firebase usando o DatabaseMethods
  Future<void> addRecipe() async {
    // Gera um ID aleatório para a receita
    String id = randomAlphaNumeric(10);
    // Cria um mapa com os dados da receita
    Map<String, dynamic> recipe = {
      "id": id,
      "title": title,
      "description": description,
      "ingredients": ingredients,
      "instructions": instructions,
    };
    // Adiciona a receita ao banco de dados e exibe uma notificação de sucesso
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
      // AppBar com título e cor do tema principal
      appBar: AppBar(
        title: const Text("Adicionar Receita"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      // Corpo do formulário para adicionar os dados da receita
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Associa a chave de validação ao formulário
          child: ListView(
            children: [
              // Título do formulário, estilizado conforme o tema do app
              Text(
                "Adicione uma nova receita",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Campo de texto para o título da receita
              _buildTextField(
                label: "Título",
                onChanged: (value) => title = value,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              // Campo de texto para a descrição da receita
              _buildTextField(
                label: "Descrição",
                onChanged: (value) => description = value,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
                maxLines: 5,
              ),
              // Campo de texto para os ingredientes da receita
              _buildTextField(
                label: "Ingredientes",
                onChanged: (value) => ingredients = value,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
                maxLines: 5,
              ),
              // Campo de texto para as instruções da receita
              _buildTextField(
                label: "Instruções",
                onChanged: (value) => instructions = value,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
                maxLines: 5,
              ),
              const SizedBox(height: 30),
              // Botão para adicionar a receita, validando o formulário antes de enviar
              ElevatedButton(
                onPressed: () async {
                  // Verifica se todos os campos são válidos antes de enviar os dados
                  if (_formKey.currentState!.validate()) {
                    await addRecipe();
                    Navigator.pop(
                        context); // Fecha a página após adicionar a receita
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

  // Método auxiliar para criar campos de texto personalizados
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
