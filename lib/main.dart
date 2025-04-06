import 'package:flutter/material.dart';
import 'package:flutter_meu_bnz/ui/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://zioluztcfwtukjibaymc.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inppb2x1enRjZnd0dWtqaWJheW1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM1NDM2MTQsImV4cCI6MjA1OTExOTYxNH0.czM8ZXm4-nIicLyxYRPRdDdtMG6FVTXF5e0lIxOQki0',
  );

  runApp(const App());
}


