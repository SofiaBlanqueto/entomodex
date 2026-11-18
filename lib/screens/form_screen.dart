import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../models/sighting.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _commonName = TextEditingController();
  final _scientificName = TextEditingController();
  final _habitat = TextEditingController();
  final _notes = TextEditingController();
  String? _order;
  DangerLevel _danger = DangerLevel.baja;

  @override
  void dispose() {
    _commonName.dispose();
    _scientificName.dispose();
    _habitat.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    // Fase 1: solo UI. El guardado real llega en las fases 3 y 4.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Formulario válido (guardado en Fase 4)')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo avistamiento')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Área de imagen (placeholder; image_picker llega en la Fase 4)
            InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Selector de imagen en Fase 4')),
              ),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: theme.colorScheme.primary.withValues(alpha: 0.4),
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_a_photo_outlined,
                        size: 48, color: theme.colorScheme.primary),
                    const SizedBox(height: 8),
                    const Text('Toca para añadir una foto'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _commonName,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(labelText: 'Nombre común *'),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'El nombre común es obligatorio'
                  : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _scientificName,
              decoration:
                  const InputDecoration(labelText: 'Nombre científico'),
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              value: _order,
              decoration: const InputDecoration(labelText: 'Orden taxonómico *'),
              items: kOrders
                  .map((o) => DropdownMenuItem(
                        value: o,
                        child: Text('${kOrderEmoji[o]} $o'),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _order = v),
              validator: (v) => v == null ? 'Selecciona un orden' : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _habitat,
              decoration: const InputDecoration(labelText: 'Hábitat'),
            ),
            const SizedBox(height: 18),
            Text('Peligrosidad', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            SegmentedButton<DangerLevel>(
              segments: DangerLevel.values
                  .map((d) => ButtonSegment(value: d, label: Text(d.label)))
                  .toList(),
              selected: {_danger},
              onSelectionChanged: (s) => setState(() => _danger = s.first),
            ),
            const SizedBox(height: 18),
            TextFormField(
              controller: _notes,
              maxLines: 4,
              maxLength: 300,
              decoration: const InputDecoration(
                labelText: 'Notas',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save_outlined),
              label: const Text('Guardar avistamiento'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
