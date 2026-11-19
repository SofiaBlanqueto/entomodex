import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/secrets.dart';
import 'core/theme.dart';
import 'screens/feed_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es');
  await Supabase.initialize(
    url: Secrets.supabaseUrl,
    anonKey: Secrets.supabaseAnonKey,
  );
  runApp(const ProviderScope(child: EntomoDexApp()));
}

class EntomoDexApp extends StatelessWidget {
  const EntomoDexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EntomoDex',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const FeedScreen(),
    );
  }
}
