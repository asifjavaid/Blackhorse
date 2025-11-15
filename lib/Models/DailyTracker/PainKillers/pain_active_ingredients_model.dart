// To parse this JSON data, do
//
//     final ingredients = ingredientsFromJson(jsonString);

import 'dart:convert';

Ingredients ingredientsFromJson(String str) => Ingredients.fromJson(json.decode(str));

String ingredientsToJson(Ingredients data) => json.encode(data.toJson());

class Ingredients {
  List<String> activeIngredients;

  Ingredients({
    required this.activeIngredients,
  });

  factory Ingredients.fromJson(Map<String, dynamic> json) => Ingredients(
        activeIngredients: List<String>.from(json["activeIngredients"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "activeIngredients": List<dynamic>.from(activeIngredients.map((x) => x)),
      };
}
