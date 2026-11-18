import 'package:flutter/material.dart';

const List<String> kOrders = [
  'Lepidoptera',
  'Coleoptera',
  'Hymenoptera',
  'Diptera',
  'Hemiptera',
  'Otros',
];

const Map<String, String> kOrderEmoji = {
  'Lepidoptera': '🦋',
  'Coleoptera': '🪲',
  'Hymenoptera': '🐝',
  'Diptera': '🪰',
  'Hemiptera': '🪳',
  'Otros': '🐛',
};

const Map<String, Color> kOrderColor = {
  'Lepidoptera': Color(0xFFB39DDB),
  'Coleoptera': Color(0xFF8D6E63),
  'Hymenoptera': Color(0xFFFFCA28),
  'Diptera': Color(0xFF81C784),
  'Hemiptera': Color(0xFF4DB6AC),
  'Otros': Color(0xFFA1887F),
};
