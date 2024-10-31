import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/model/Recipe.dart';

class DatabaseMethods {
  Stream<List<Recipe>> getRecipes() {
    return FirebaseFirestore.instance
        .collection("recipe")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Recipe.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  Future addRecipe(Map<String, dynamic> recipe, String id) async {
    return await FirebaseFirestore.instance
        .collection("recipe")
        .doc(id)
        .set(recipe);
  }

  Future updateRecipe(String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection("recipe")
        .doc(id)
        .update(updateInfo);
  }

  Future deleteRecipe(String id) async {
    return await FirebaseFirestore.instance
        .collection("recipe")
        .doc(id)
        .delete();
  }
}
