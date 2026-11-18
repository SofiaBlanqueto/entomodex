import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../core/constants.dart';
import '../models/sighting.dart';
import '../widgets/insect_image.dart';

class DetailScreen extends StatelessWidget {
  final Sighting sighting;
  const DetailScreen({super.key, required this.sighting});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final date = DateFormat("d 'de' MMMM, y", 'es').format(sighting.createdAt);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            backgroundColor: theme.colorScheme.surface,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'sighting-${sighting.id}',
                child: InsectImage(
                  imageUrl: sighting.imageUrl,
                  orderType: sighting.orderType,
                  emojiSize: 110,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sighting.commonName,
                    style: GoogleFonts.fraunces(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    sighting.scientificName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(
                        avatar: Text(kOrderEmoji[sighting.orderType] ?? '🐛'),
                        label: Text(sighting.orderType),
                      ),
                      Chip(
                        avatar: Icon(Icons.warning_amber_rounded,
                            size: 18, color: sighting.danger.color),
                        label: Text('Peligrosidad: ${sighting.danger.label}'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _Section(
                    icon: Icons.forest_outlined,
                    title: 'Hábitat',
                    body: sighting.habitat,
                  ),
                  _Section(
                    icon: Icons.event_outlined,
                    title: 'Fecha de avistamiento',
                    body: date,
                  ),
                  _Section(
                    icon: Icons.notes_outlined,
                    title: 'Notas',
                    body: sighting.notes,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;

  const _Section({required this.icon, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: theme.colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: theme.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(body, style: theme.textTheme.bodyLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
