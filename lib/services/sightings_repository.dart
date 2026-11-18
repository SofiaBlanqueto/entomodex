import '../data/mock_data.dart';
import '../models/sighting.dart';

/// Fuente de datos. En la Fase 3 se reemplaza el contenido de estos
/// métodos por llamadas a Supabase; el resto de la app no cambia.
class SightingsRepository {
  final List<Sighting> _store = List.of(mockSightings);

  Future<List<Sighting>> fetchSightings() async {
    await Future.delayed(const Duration(milliseconds: 900)); // simula la red
    return List.of(_store);
  }

  Future<Sighting> insertSighting(Sighting sighting) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _store.insert(0, sighting);
    return sighting;
  }
}
