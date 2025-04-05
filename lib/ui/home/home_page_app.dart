import 'package:flutter/material.dart';
import 'package:flutter_meu_bnz/ui/home/home.dart';
import 'package:flutter_meu_bnz/ui/Jornal/journal_ofertas_screen.dart';
import 'package:flutter_meu_bnz/utils/widgets/float_action_button.dart';
import 'package:flutter_meu_bnz/ui/perfil/perfil_page.dart';

class HomePageApp extends StatelessWidget {
  const HomePageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MenuFloatingActionButton(),
      appBar: AppBar(
        backgroundColor: Color(0xFF253885),
        toolbarHeight: 0,
      ),
      body: Home(),
    );
  }
}

void main() => runApp(MaterialApp(home: HomePageApp()));
