import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/filters_provider.dart';
import '../providers/sightings_provider.dart';
import '../widgets/order_chips.dart';
import '../widgets/sighting_card.dart';
import 'detail_screen.dart';
import 'form_screen.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sightings = ref.watch(filteredSightingsProvider);
    final selectedOrder = ref.watch(selectedOrderProvider);

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
              onChanged: (v) => ref.read(searchQueryProvider.notifier).set(v),
            ),
          ),
          OrderChips(
            selected: selectedOrder,
            onChanged: (order) =>
                ref.read(selectedOrderProvider.notifier).set(order),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: sightings.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => _ErrorState(
                message: 'No se pudieron cargar los avistamientos',
                onRetry: () => ref.invalidate(sightingsProvider),
              ),
              data: (items) => items.isEmpty
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

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.cloud_off_outlined, size: 64, color: Colors.black38),
          const SizedBox(height: 12),
          Text(message),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }
}
