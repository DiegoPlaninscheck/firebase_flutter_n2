import 'package:firebase_flutter/services/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../model/Recipe.dart';

// Tela de edição de receita, recebendo um objeto Recipe como parâmetro
class EditRecipePage extends StatefulWidget {
  final Recipe recipe;

  const EditRecipePage({Key? key, required this.recipe}) : super(key: key);

  @override
  _EditRecipePageState createState() => _EditRecipePageState();
}

class _EditRecipePageState extends State<EditRecipePage> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para os campos de texto do formulário
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _ingredientsController;
  late TextEditingController _instructionsController;

  @override
  void initState() {
    super.initState();

    // Inicializa os controladores com os valores da receita recebida
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
    // Libera os controladores quando a tela é fechada
    _titleController.dispose();
    _descriptionController.dispose();
    _ingredientsController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  // Função para atualizar a receita no banco de dados
  Future<void> _updateRecipe() async {
    // Verifica se o formulário é válido
    if (_formKey.currentState!.validate()) {
      try {
        // Chama o método de atualização de receita no banco de dados
        await DatabaseMethods().updateRecipe(widget.recipe.id, {
          'title': _titleController.text,
          'description': _descriptionController.text,
          'ingredients': _ingredientsController.text,
          'instructions': _instructionsController.text
        });

        // Mostra uma mensagem de sucesso
        Fluttertoast.showToast(
          msg: "Receita atualizada com sucesso!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        // Fecha a tela de edição
        Navigator.pop(context);
      } catch (e) {
        // Mostra uma mensagem de erro caso a atualização falhe
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao atualizar a receita: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Receita'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Título e descrição da tela
              Text(
                "Edite os detalhes da sua receita",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Campos de texto para editar título, descrição, ingredientes e instruções
              _buildTextField(
                controller: _titleController,
                label: 'Título',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o título';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller: _descriptionController,
                label: 'Descrição',
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller: _ingredientsController,
                label: 'Ingredientes',
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira os ingredientes';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller: _instructionsController,
                label: 'Instruções',
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira as instruções';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              // Botão para salvar as alterações
              ElevatedButton(
                onPressed: _updateRecipe,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Salvar Alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para criar campos de texto com estilo personalizado e validação
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
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
        maxLines: maxLines,
        validator: validator,
      ),
    );
  }
}
