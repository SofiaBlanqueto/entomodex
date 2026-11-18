import 'package:flutter/material.dart';
import '../core/constants.dart';

/// Muestra la foto si hay URL; si no, un placeholder con el emoji del orden.
/// En la Fase 4 se puede cambiar Image.network por CachedNetworkImage.
class InsectImage extends StatelessWidget {
  final String imageUrl;
  final String orderType;
  final double emojiSize;

  const InsectImage({
    super.key,
    required this.imageUrl,
    required this.orderType,
    this.emojiSize = 56,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isNotEmpty) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, __, ___) => _placeholder(),
      );
    }
    return _placeholder();
  }

  Widget _placeholder() {
    final color = kOrderColor[orderType] ?? kOrderColor['Otros']!;
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withValues(alpha: 0.5), color],
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        kOrderEmoji[orderType] ?? '🐛',
        style: TextStyle(fontSize: emojiSize),
      ),
    );
  }
}
