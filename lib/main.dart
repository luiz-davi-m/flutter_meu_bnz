//import 'package:flutter/material.dart';
//import 'package:flutter_meu_bnz/data/services/produto.service.dart';
//import 'package:flutter_meu_bnz/ui/app.dart';

//void main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  //runApp(const App());
//}

import 'package:flutter/material.dart';
import 'package:flutter_meu_bnz/screens/journal_ofertas_screen.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();

runApp(const MyApp());
}

class MyApp extends StatelessWidget {
const MyApp({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: JournalOfertasScreen(),
 );
}
}


