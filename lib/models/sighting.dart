import 'package:flutter/material.dart';

enum DangerLevel {
  baja('Baja', Color(0xFF2E7D32)),
  media('Media', Color(0xFFEF6C00)),
  alta('Alta', Color(0xFFC62828));

  final String label;
  final Color color;
  const DangerLevel(this.label, this.color);
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
}
