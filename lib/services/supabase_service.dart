import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/sighting.dart';

/// Acceso a la tabla `sightings`. Reemplaza al repositorio simulado de la Fase 2.
class SupabaseService {
  final SupabaseClient _client;
  SupabaseService(this._client);

  static const _table = 'sightings';

  Future<List<Sighting>> fetchSightings() async {
    final rows = await _client
        .from(_table)
        .select()
        .order('created_at', ascending: false);

    return rows
        .map<Sighting>((row) => Sighting.fromJson(row))
        .toList();
  }

  Future<Sighting> insertSighting(Sighting sighting) async {
    final row = await _client
        .from(_table)
        .insert(sighting.toInsertJson())
        .select()
        .single();

    return Sighting.fromJson(row);
  }
}
