class Recipe {
  String id;
  String title;
  String description;
  String ingredients;
  String instructions;

  Recipe(
      {required this.id,
      required this.title,
      required this.description,
      required this.ingredients,
      required this.instructions});

  factory Recipe.fromMap(Map<String, dynamic> data, String documentId) {
    return Recipe(
      id: documentId,
      title: data['title'],
      description: data['description'],
      ingredients: data['ingredients'],
      instructions: data['instructions'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'ingredients': ingredients,
      'instructions': instructions,
    };
  }
}
