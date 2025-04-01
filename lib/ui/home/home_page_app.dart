import 'package:flutter/material.dart';
import 'package:flutter_meu_bnz/ui/home/home.dart';
import 'package:flutter_meu_bnz/utils/widgets/float_action_button.dart';

class HomePageApp extends StatelessWidget {
  const HomePageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF253885),
        toolbarHeight: 0,
      ),
      body: Home(),
      floatingActionButton: MenuFloatingActionButton(),
    );
  }
}

void main() => runApp(MaterialApp(home: HomePageApp()));
