import 'package:flutter/material.dart';

enum DangerLevel {
  baja('Baja', Color(0xFF2E7D32)),
  media('Media', Color(0xFFEF6C00)),
  alta('Alta', Color(0xFFC62828));

  final String label;
  final Color color;
  const DangerLevel(this.label, this.color);

  /// Convierte el texto guardado en la BD ('baja', 'media', 'alta').
  static DangerLevel fromName(String? name) => DangerLevel.values.firstWhere(
    (d) => d.name == name,
    orElse: () => DangerLevel.baja,
  );
}

class Sighting {
  final String id;
  final String commonName;
  final String scientificName;
  final String orderType;
  final String habitat;
  final String notes;
  final String imageUrl; // vacío = se muestra placeholder
  final DangerLevel danger;
  final DateTime createdAt;

  const Sighting({
    required this.id,
    required this.commonName,
    required this.scientificName,
    required this.orderType,
    required this.habitat,
    required this.notes,
    required this.danger,
    required this.createdAt,
    this.imageUrl = '',
  });

  /// Los nombres de las llaves coinciden con las columnas de la tabla `sightings`.
  factory Sighting.fromJson(Map<String, dynamic> json) => Sighting(
    id: json['id'] as String,
    commonName: json['common_name'] as String,
    scientificName: (json['scientific_name'] as String?) ?? '',
    orderType: json['order_type'] as String,
    habitat: (json['habitat'] as String?) ?? '',
    notes: (json['notes'] as String?) ?? '',
    imageUrl: (json['image_url'] as String?) ?? '',
    danger: DangerLevel.fromName(json['danger_level'] as String?),
    createdAt: DateTime.parse(json['created_at'] as String).toLocal(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'common_name': commonName,
    'scientific_name': scientificName,
    'order_type': orderType,
    'habitat': habitat,
    'notes': notes,
    'image_url': imageUrl,
    'danger_level': danger.name,
    'created_at': createdAt.toUtc().toIso8601String(),
  };

  /// Para INSERT: `id` y `created_at` los genera la base de datos.
  Map<String, dynamic> toInsertJson() => {
    'common_name': commonName,
    'scientific_name': scientificName,
    'order_type': orderType,
    'habitat': habitat,
    'notes': notes,
    'image_url': imageUrl,
    'danger_level': danger.name,
  };
}
