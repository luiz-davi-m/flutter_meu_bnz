import 'package:flutter/material.dart';
import 'package:flutter_meu_bnz/ui/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://myhvlmbsuoxsmdufugwc.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im15aHZsbWJzdW94c21kdWZ1Z3djIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM1NTQxMDgsImV4cCI6MjA1OTEzMDEwOH0.kI4NT59vmOkxRkv8rAb9Dl4Gu5pUTaiyYlo-divzoZE',
  );

  runApp(const App());
}
