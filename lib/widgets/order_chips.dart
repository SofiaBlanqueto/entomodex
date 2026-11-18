import 'package:flutter/material.dart';
import '../core/constants.dart';

class OrderChips extends StatelessWidget {
  final String? selected;
  final ValueChanged<String?> onChanged;

  const OrderChips({super.key, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: kOrders.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final order = kOrders[i];
          final isSelected = selected == order;
          return ChoiceChip(
            label: Text('${kOrderEmoji[order]} $order'),
            selected: isSelected,
            // Tocar el chip activo quita el filtro
            onSelected: (_) => onChanged(isSelected ? null : order),
          );
        },
      ),
    );
  }
}
