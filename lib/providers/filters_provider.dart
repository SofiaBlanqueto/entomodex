import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/sighting.dart';
import 'sightings_provider.dart';

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';
  void set(String value) => state = value;
}

class SelectedOrderNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  /// OrderChips envía null cuando se toca el chip activo (quita el filtro).
  void set(String? order) => state = order;
}

final searchQueryProvider =
    NotifierProvider<SearchQueryNotifier, String>(SearchQueryNotifier.new);

final selectedOrderProvider =
    NotifierProvider<SelectedOrderNotifier, String?>(SelectedOrderNotifier.new);

/// Combina lista + filtros EN MEMORIA: no vuelve a consultar la base de datos.
final filteredSightingsProvider =
    Provider<AsyncValue<List<Sighting>>>((ref) {
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();
  final order = ref.watch(selectedOrderProvider);

  return ref.watch(sightingsProvider).whenData(
        (list) => list.where((s) {
          final matchesOrder = order == null || s.orderType == order;
          final matchesText = s.commonName.toLowerCase().contains(query) ||
              s.scientificName.toLowerCase().contains(query);
          return matchesOrder && matchesText;
        }).toList(),
      );
});
