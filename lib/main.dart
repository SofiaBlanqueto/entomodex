import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/theme.dart';
import 'screens/feed_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es'); // para formatear fechas en español
  runApp(const EntomoDexApp());
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
