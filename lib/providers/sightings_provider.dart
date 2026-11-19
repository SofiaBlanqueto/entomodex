import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/sighting.dart';
import '../services/supabase_service.dart';

final supabaseServiceProvider = Provider<SupabaseService>(
  (ref) => SupabaseService(Supabase.instance.client),
);

/// Lista completa de avistamientos con estados loading / error / data.
class SightingsNotifier extends AsyncNotifier<List<Sighting>> {
  @override
  Future<List<Sighting>> build() {
    return ref.read(supabaseServiceProvider).fetchSightings();
  }

  /// Guarda en Supabase y agrega al inicio de la lista sin reconsultar todo.
  Future<void> add(Sighting sighting) async {
    final saved =
        await ref.read(supabaseServiceProvider).insertSighting(sighting);
    state = AsyncData([saved, ...state.value ?? <Sighting>[]]);
  }
}

final sightingsProvider =
    AsyncNotifierProvider<SightingsNotifier, List<Sighting>>(
        SightingsNotifier.new);
