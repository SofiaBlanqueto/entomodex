import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/sighting.dart';
import '../widgets/order_chips.dart';
import '../widgets/sighting_card.dart';
import 'detail_screen.dart';
import 'form_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  String _query = '';
  String? _order;

  List<Sighting> get _filtered {
    final q = _query.toLowerCase();
    return mockSightings.where((s) {
      final matchesOrder = _order == null || s.orderType == _order;
      final matchesText = s.commonName.toLowerCase().contains(q) ||
          s.scientificName.toLowerCase().contains(q);
      return matchesOrder && matchesText;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;

    return Scaffold(
      appBar: AppBar(title: const Text('EntomoDex')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: SearchBar(
              hintText: 'Buscar por nombre común o científico',
              leading: const Icon(Icons.search),
              elevation: const WidgetStatePropertyAll(0),
              backgroundColor: const WidgetStatePropertyAll(Colors.white),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          OrderChips(
            selected: _order,
            onChanged: (v) => setState(() => _order = v),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: items.isEmpty
                ? const _EmptyState()
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: 0.78,
                    ),
                    itemCount: items.length,
                    itemBuilder: (_, i) => SightingCard(
                      sighting: items[i],
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(sighting: items[i]),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const FormScreen()),
        ),
        icon: const Icon(Icons.add_a_photo_outlined),
        label: const Text('Nuevo avistamiento'),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bug_report_outlined, size: 64, color: Colors.black38),
          SizedBox(height: 12),
          Text('No hay avistamientos con estos filtros'),
        ],
      ),
    );
  }
}
