import 'package:flutter/material.dart';

class Category {
  String id;
  String name;
  Color color;
  bool seleccionado;
  bool isNote;

  Category({
    required this.id,
    required this.name,
    required this.color,
    this.seleccionado = false,
    this.isNote = false,
  });

  // Método para crear una categoria a partir de un mapa (JSON)
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'] ?? "Sin nombre",
      color: json['color'] ?? Colors.green,
      seleccionado: json['seleccionado'] ?? false,
      isNote: json['isNote'] ?? false,
    );
  }

  // Convertir una categoria en un mapa (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'seleccionado': seleccionado,
      'isNote': isNote,
    };
  }

  // Sobrescribimos el método toString para mostrar los valores de la categoría
  @override
  String toString() {
    return 'Category{id: $id, name: $name, color: $color, seleccionado: $seleccionado}';
  }
}
