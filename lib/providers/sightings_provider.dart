import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/sighting.dart';
import '../services/sightings_repository.dart';

final sightingsRepositoryProvider =
    Provider<SightingsRepository>((ref) => SightingsRepository());

/// Lista completa de avistamientos con estados loading / error / data.
class SightingsNotifier extends AsyncNotifier<List<Sighting>> {
  @override
  Future<List<Sighting>> build() {
    return ref.read(sightingsRepositoryProvider).fetchSightings();
  }

  /// Guarda y agrega al inicio de la lista sin volver a consultar todo.
  Future<void> add(Sighting sighting) async {
    final saved =
        await ref.read(sightingsRepositoryProvider).insertSighting(sighting);
    state = AsyncData([saved, ...state.value ?? <Sighting>[]]);
  }
}

final sightingsProvider =
    AsyncNotifierProvider<SightingsNotifier, List<Sighting>>(
        SightingsNotifier.new);
